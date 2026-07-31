import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/services/push/customer_push_wake_coordinator.dart';
import 'package:delivery_app/features/notification/domain/entities/notification_entity.dart';
import 'package:delivery_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:delivery_app/features/notification/presentation/providers/notification_providers.dart';
import 'package:delivery_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:delivery_app/features/profile/domain/entities/user_entity.dart';
import 'package:delivery_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  testWidgets(
    'notification actions expose failure and retry without losing rows',
    (tester) async {
      final notifications = _FakeNotificationRepository();
      await pumpTestApp(
        tester,
        child: const NotificationScreen(),
        overrides: [
          profileRepositoryProvider.overrideWithValue(_FakeProfileRepository()),
          notificationRepositoryProvider.overrideWithValue(notifications),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('Đơn mới'), findsOneWidget);
      expect(find.text('Cập nhật hệ thống'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      notifications.markFailure = const ServerFailure('Không thể đánh dấu');
      await tester.tap(find.text('Đơn mới'));
      await tester.pumpAndSettle();
      expect(find.text('Không thể đánh dấu'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.text('Đơn mới'));
      await tester.pumpAndSettle();
      expect(notifications.markCalls, 2);
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.done_all));
      await tester.pumpAndSettle();
      expect(notifications.markAllCalls, 1);
      expect(find.byIcon(Icons.done_all), findsNothing);

      notifications.deleteFailure = const ServerFailure('Không thể xóa');
      var dismissible = tester.widget<Dismissible>(
        find.byKey(const Key('notification_902')),
      );
      expect(
        await dismissible.confirmDismiss!(DismissDirection.endToStart),
        isFalse,
      );
      await tester.pumpAndSettle();
      expect(notifications.deleteCalls, 1);
      expect(find.text('Cập nhật hệ thống'), findsOneWidget);

      dismissible = tester.widget<Dismissible>(
        find.byKey(const Key('notification_902')),
      );
      expect(
        await dismissible.confirmDismiss!(DismissDirection.endToStart),
        isTrue,
      );
      await tester.pumpAndSettle();
      expect(notifications.deleteCalls, 2);
      expect(find.text('Cập nhật hệ thống'), findsNothing);
    },
  );

  testWidgets('notification load failure shows an explicit retry action', (
    tester,
  ) async {
    final notifications = _FakeNotificationRepository()
      ..loadFailure = const NetworkFailure('Mất kết nối thông báo');
    await pumpTestApp(
      tester,
      child: const NotificationScreen(),
      overrides: [
        profileRepositoryProvider.overrideWithValue(_FakeProfileRepository()),
        notificationRepositoryProvider.overrideWithValue(notifications),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('Mất kết nối thông báo'), findsOneWidget);
    notifications.loadFailure = null;
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();

    expect(find.text('Đơn mới'), findsOneWidget);
    expect(notifications.loadCalls, 2);
  });

  testWidgets('a deduplicated push wake refreshes the visible durable inbox', (
    tester,
  ) async {
    final notifications = _FakeNotificationRepository();
    await pumpTestApp(
      tester,
      child: const NotificationScreen(),
      overrides: [
        profileRepositoryProvider.overrideWithValue(_FakeProfileRepository()),
        notificationRepositoryProvider.overrideWithValue(notifications),
      ],
    );
    await tester.pumpAndSettle();
    expect(notifications.loadCalls, 1);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(NotificationScreen)),
    );
    container.read(notificationWakeEpochProvider.notifier).state += 1;
    await tester.pumpAndSettle();

    expect(notifications.loadCalls, 2);
  });
}

class _FakeNotificationRepository implements NotificationRepository {
  _FakeNotificationRepository()
    : rows = [
        buildNotification(),
        buildNotification(id: 902, title: 'Cập nhật hệ thống'),
      ];

  List<NotificationEntity> rows;
  Failure? loadFailure;
  Failure? markFailure;
  Failure? deleteFailure;
  int loadCalls = 0;
  int markCalls = 0;
  int markAllCalls = 0;
  int deleteCalls = 0;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getUserNotifications(
    int userId,
  ) async {
    loadCalls += 1;
    final failure = loadFailure;
    if (failure != null) return Left(failure);
    return Right([...rows]);
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async =>
      Right(rows.where((row) => !row.isRead).length);

  @override
  Future<Either<Failure, List<NotificationEntity>>>
  getUnreadNotifications() async =>
      Right(rows.where((row) => !row.isRead).toList());

  @override
  Future<Either<Failure, NotificationEntity>> markAsRead(int id) async {
    markCalls += 1;
    final failure = markFailure;
    markFailure = null;
    if (failure != null) return Left(failure);
    final index = rows.indexWhere((row) => row.id == id);
    rows[index] = rows[index].copyWith(isRead: true);
    return Right(rows[index]);
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    markAllCalls += 1;
    rows = rows.map((row) => row.copyWith(isRead: true)).toList();
    return const Right(0);
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(int id) async {
    deleteCalls += 1;
    final failure = deleteFailure;
    deleteFailure = null;
    if (failure != null) return Left(failure);
    rows.removeWhere((row) => row.id == id);
    return const Right(true);
  }
}

class _FakeProfileRepository implements ProfileRepository {
  final UserEntity profile = buildProfile();

  @override
  Future<Either<Failure, UserEntity?>> getCachedUserProfile() async =>
      Right(profile);

  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async => Right(profile);

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile(
    UserEntity user,
  ) async => Right(user);

  @override
  Future<Either<Failure, void>> cacheUserProfile(UserEntity user) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> clearCachedUserProfile() async =>
      const Right(null);
}
