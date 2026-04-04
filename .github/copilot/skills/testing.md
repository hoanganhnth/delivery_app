# Skill: Testing

> Use when: Writing unit tests, widget tests

## Pattern: UseCase Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

class MockFeatureRepository extends Mock implements FeatureRepository {}

void main() {
  late GetFeatureUseCase useCase;
  late MockFeatureRepository mockRepository;

  setUp(() {
    mockRepository = MockFeatureRepository();
    useCase = GetFeatureUseCase(mockRepository);
  });

  group('GetFeatureUseCase', () {
    test('should return feature when repository succeeds', () async {
      // Arrange
      final feature = FeatureEntity(id: '1', name: 'Test');
      when(() => mockRepository.getById('1'))
          .thenAnswer((_) async => right(feature));

      // Act
      final result = await useCase(GetFeatureParams(id: '1'));

      // Assert
      expect(result, right(feature));
      verify(() => mockRepository.getById('1')).called(1);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(() => mockRepository.getById('1'))
          .thenAnswer((_) async => left(ServerFailure('Error')));

      // Act
      final result = await useCase(GetFeatureParams(id: '1'));

      // Assert
      expect(result.isLeft(), true);
    });
  });
}
```

## Pattern: Notifier Test

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  late MockGetFeatureUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetFeatureUseCase();
    container = ProviderContainer(
      overrides: [
        getFeatureUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('loadItems updates state correctly', () async {
    // Arrange
    final items = [FeatureEntity(id: '1', name: 'Test')];
    when(() => mockUseCase(any())).thenAnswer((_) async => right(items));

    // Act
    final notifier = container.read(featureNotifierProvider.notifier);
    await notifier.loadItems();

    // Assert
    final state = container.read(featureNotifierProvider);
    expect(state.isLoading, false);
    expect(state.items, items);
    expect(state.failure, null);
  });
}
```

## Pattern: Widget Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('shows loading indicator', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          featureNotifierProvider.overrideWith(
            (ref) => FeatureNotifier()..state = FeatureState(isLoading: true),
          ),
        ],
        child: MaterialApp(home: FeatureScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

## Test Commands

```bash
fvm flutter test                           # All tests
fvm flutter test test/features/auth/       # Feature tests
fvm flutter test --coverage                # With coverage
```
