import 'package:delivery_app/features/profile/application/profile_intent.dart';
import 'package:delivery_app/features/profile/application/profile_view_state.dart';
import 'package:delivery_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('renders user data and emits typed profile actions', (
    tester,
  ) async {
    final intents = <ProfileIntent>[];
    await pumpTestApp(
      tester,
      child: ProfileView(
        state: const ProfileViewState(
          data: ProfileViewData(
            displayName: 'Customer Test',
            email: 'customer@test.dev',
            initial: 'C',
          ),
        ),
        onIntent: intents.add,
      ),
    );

    expect(find.text('Customer Test'), findsOneWidget);
    expect(find.text('customer@test.dev'), findsNothing);
    await tester.tap(find.text('Personal information'));
    expect(intents.last, isA<ProfilePersonalInformationRequested>());
    await tester.tap(find.text('Ví Voucher & Khuyến mãi'));
    expect(intents.last, isA<ProfileVouchersRequested>());

    await tester.tap(find.text('Trung tâm Hỗ trợ & CSKH'));
    expect(intents.last, isA<ProfileSupportRequested>());

    await tester.tap(find.text('Livestream Săn Deal'));
    expect(intents.last, isA<ProfileLivestreamRequested>());

    await tester.tap(find.text('My Addresses'));
    expect(intents.last, isA<ProfileAddressesRequested>());

    await tester.tap(find.text('Log Out'));
    expect(intents.last, isA<ProfileLogoutRequested>());
  });
}
