import 'package:equatable/equatable.dart';

import 'address_list_state.dart';

sealed class AddressListEffect extends Equatable {
  const AddressListEffect();
}

final class AddressListNavigateBack extends AddressListEffect {
  const AddressListNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class AddressListNavigateToAdd extends AddressListEffect {
  const AddressListNavigateToAdd();

  @override
  List<Object?> get props => const [];
}

final class AddressListNavigateToEdit extends AddressListEffect {
  const AddressListNavigateToEdit(this.addressId);

  final int addressId;

  @override
  List<Object?> get props => [addressId];
}

final class AddressListConfirmDelete extends AddressListEffect {
  const AddressListConfirmDelete(this.address);

  final AddressListItemViewData address;

  @override
  List<Object?> get props => [address];
}

enum AddressListOperation { delete, setDefault }

/// The page converts this semantic operation result into the existing toast.
final class AddressListShowOperationFeedback extends AddressListEffect {
  const AddressListShowOperationFeedback({
    required this.operation,
    required this.isSuccess,
    this.addressLabel,
  });

  final AddressListOperation operation;
  final bool isSuccess;
  final String? addressLabel;

  @override
  List<Object?> get props => [operation, isSuccess, addressLabel];
}
