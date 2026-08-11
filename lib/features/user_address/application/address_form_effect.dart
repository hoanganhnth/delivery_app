import 'package:equatable/equatable.dart';

sealed class AddressFormEffect extends Equatable {
  const AddressFormEffect();
}

final class AddressFormNavigateBack extends AddressFormEffect {
  const AddressFormNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class AddressFormConfirmDelete extends AddressFormEffect {
  const AddressFormConfirmDelete(this.addressLabel);

  final String addressLabel;

  @override
  List<Object?> get props => [addressLabel];
}

enum AddressFormOperation { create, update, delete }

/// The page resolves this semantic result to the established address toast.
final class AddressFormShowOperationFeedback extends AddressFormEffect {
  const AddressFormShowOperationFeedback({
    required this.operation,
    required this.isSuccess,
    this.addressLabel,
    this.message,
  });

  final AddressFormOperation operation;
  final bool isSuccess;
  final String? addressLabel;
  final String? message;

  @override
  List<Object?> get props => [operation, isSuccess, addressLabel, message];
}

final class AddressFormShowMessage extends AddressFormEffect {
  const AddressFormShowMessage(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
