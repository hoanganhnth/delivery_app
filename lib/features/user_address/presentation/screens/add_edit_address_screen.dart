import 'package:delivery_app/features/user_address/application/address_form_state.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:flutter/widgets.dart';

import '../pages/address_form_page.dart';

/// Compatibility route entry point. New code should use [AddressFormPage].
class AddEditAddressScreen extends StatelessWidget {
  const AddEditAddressScreen({super.key, this.address, this.addressId});

  final UserAddressEntity? address;
  final int? addressId;

  @override
  Widget build(BuildContext context) => AddressFormPage(
    target: AddressFormTarget(addressId: addressId, initialAddress: address),
  );
}
