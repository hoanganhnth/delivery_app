import 'package:delivery_app/features/user_address/application/address_form_intent.dart';
import 'package:delivery_app/features/user_address/application/address_form_state.dart';
import 'package:delivery_app/features/user_address/application/address_list_context.dart';
import 'package:delivery_app/features/user_address/application/address_list_intent.dart';
import 'package:delivery_app/features/user_address/application/address_list_state.dart';
import 'package:delivery_app/features/user_address/presentation/components/address_list_card.dart';
import 'package:delivery_app/features/user_address/presentation/pages/address_list_page.dart';
import 'package:delivery_app/features/user_address/presentation/screens/address_list_screen.dart';
import 'package:delivery_app/features/user_address/presentation/views/address_form_view.dart';
import 'package:delivery_app/features/user_address/presentation/views/address_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  for (final selectionContext in AddressListContext.values) {
    testWidgets(
      'phone address row preserves ${selectionContext.name} context',
      (tester) async {
        final intents = <AddressListIntent>[];
        await pumpTestApp(
          tester,
          viewport: const Size(320, 740),
          child: AddressListView(
            selectionContext: selectionContext,
            state: const AddressListViewState(
              isLoading: false,
              selectedAddressId: 401,
              items: [
                AddressListItemViewData(
                  id: 401,
                  label: 'Nhà',
                  recipientName: 'Khách thử nghiệm',
                  phoneNumber: '0900000002',
                  fullAddress: '2 Đường Khách, Quận 1',
                  isDefault: true,
                  hasCoordinates: true,
                ),
              ],
            ),
            onIntent: intents.add,
          ),
        );
        expect(find.byType(FloatingActionButton), findsNothing);
        await tester.tap(find.text('Khách thử nghiệm'));
        if (selectionContext == AddressListContext.management) {
          expect(intents.single, isA<AddressListEditRequested>());
        } else {
          expect(
            (intents.single as AddressListSelectRequested).context,
            selectionContext,
          );
        }
        await tester.tap(find.byKey(const Key('address_edit_401')));
        expect(intents.last, isA<AddressListEditRequested>());
        await tester.tap(find.byKey(const Key('address_list_add_fab')));
        expect(intents.last, isA<AddressListAddRequested>());
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('address list renders data and emits typed intents', (
    tester,
  ) async {
    final intents = <AddressListIntent>[];
    await pumpTestApp(
      tester,
      child: AddressListView(
        selectionContext: AddressListContext.home,
        isSelectMode: true,
        state: const AddressListViewState(
          isLoading: false,
          selectedAddressId: 401,
          items: [
            AddressListItemViewData(
              id: 401,
              label: 'Nhà',
              recipientName: 'Khách thử nghiệm',
              phoneNumber: '0900000002',
              fullAddress: '2 Đường Khách, Quận 1',
              isDefault: true,
              hasCoordinates: true,
            ),
          ],
        ),
        onIntent: intents.add,
      ),
    );

    await tester.tap(find.byType(AddressListCard));
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chỉnh sửa'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('address_list_add_action')));

    expect(intents[0], isA<AddressListSelectRequested>());
    expect((intents[0] as AddressListSelectRequested).addressId, 401);
    expect(
      (intents[0] as AddressListSelectRequested).context,
      AddressListContext.home,
    );
    expect(intents[1], isA<AddressListEditRequested>());
    expect(intents[2], isA<AddressListAddRequested>());
  });

  testWidgets(
    'my addresses shows the default badge without an active selection border',
    (tester) async {
      await pumpTestApp(
        tester,
        child: AddressListView(
          selectionContext: AddressListContext.management,
          state: const AddressListViewState(
            isLoading: false,
            selectedAddressId: 401,
            items: [
              AddressListItemViewData(
                id: 401,
                label: 'Nhà',
                recipientName: 'Khách thử nghiệm',
                phoneNumber: '0900000002',
                fullAddress: '2 Đường Khách, Quận 1',
                isDefault: true,
                hasCoordinates: true,
              ),
            ],
          ),
          onIntent: (_) {},
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      final shape = card.shape! as RoundedRectangleBorder;
      expect(shape.side.width, 1);
      expect(find.text('Mặc định'), findsOneWidget);
      expect(find.text('Đã chọn'), findsNothing);
    },
  );

  testWidgets('address form emits typed field and submit intents', (
    tester,
  ) async {
    final intents = <AddressFormIntent>[];
    await pumpTestApp(
      tester,
      child: AddressFormView(
        state: const AddressFormViewState(
          draft: AddressFormDraft(
            label: 'Nhà riêng',
            recipientName: 'Khách thử nghiệm',
            phoneNumber: '0900000002',
            addressLine: '2 Đường Khách',
            ward: 'Phường Test',
            district: 'Quận 1',
            city: 'TP.HCM',
          ),
        ),
        onIntent: intents.add,
      ),
    );

    await tester.enterText(
      find.byKey(const Key('address_form_label')),
      'Nhà mới',
    );
    await tester.tap(find.text('Công ty'));
    await tester.tap(find.byKey(const Key('address_form_submit')));

    expect(intents[0], isA<AddressFormFieldChanged>());
    final changed = intents[0] as AddressFormFieldChanged;
    expect(changed.field, AddressFormField.label);
    expect(changed.value, 'Nhà mới');
    expect(intents[1], isA<AddressFormFieldChanged>());
    expect((intents[1] as AddressFormFieldChanged).value, 'Công ty');
    expect(intents[2], isA<AddressFormSubmitRequested>());
  });

  testWidgets(
    'AddressListScreen mounts cleanly without Riverpod building assertion',
    (tester) async {
      await pumpTestApp(
        tester,
        child: const AddressListScreen(
          selectionContext: AddressListContext.management,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AddressListScreen), findsOneWidget);
      expect(find.byType(AddressListPage), findsOneWidget);
    },
  );
}
