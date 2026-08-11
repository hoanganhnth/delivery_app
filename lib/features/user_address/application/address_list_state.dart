import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:equatable/equatable.dart';

import 'address_list_effect.dart';

/// Presentation data deliberately does not expose the address domain entity.
final class AddressListItemViewData extends Equatable {
  const AddressListItemViewData({
    required this.id,
    required this.label,
    required this.recipientName,
    required this.phoneNumber,
    required this.fullAddress,
    required this.isDefault,
    required this.hasCoordinates,
  });

  final int id;
  final String label;
  final String recipientName;
  final String phoneNumber;
  final String fullAddress;
  final bool isDefault;
  final bool hasCoordinates;

  @override
  List<Object?> get props => [
    id,
    label,
    recipientName,
    phoneNumber,
    fullAddress,
    isDefault,
    hasCoordinates,
  ];
}

final class AddressListViewState extends Equatable {
  const AddressListViewState({
    this.items = const <AddressListItemViewData>[],
    this.selectedAddressId,
    this.isLoading = true,
    this.errorMessage,
    this.operationInProgressId,
    this.effects = const <UiEffectEnvelope<AddressListEffect>>[],
  });

  final List<AddressListItemViewData> items;
  final int? selectedAddressId;
  final bool isLoading;
  final String? errorMessage;
  final int? operationInProgressId;
  final List<UiEffectEnvelope<AddressListEffect>> effects;

  bool get hasLoadError => errorMessage != null;
  bool get isEmpty => items.isEmpty;
  bool get isOperating => operationInProgressId != null;
  AddressListItemViewData? get selectedAddress =>
      items.where((item) => item.id == selectedAddressId).firstOrNull;
  AddressListItemViewData? get defaultAddress =>
      items.where((item) => item.isDefault).firstOrNull;

  AddressListViewState copyWith({
    List<AddressListItemViewData>? items,
    int? selectedAddressId,
    bool clearSelectedAddress = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    int? operationInProgressId,
    bool clearOperationInProgress = false,
    List<UiEffectEnvelope<AddressListEffect>>? effects,
  }) {
    return AddressListViewState(
      items: items ?? this.items,
      selectedAddressId: clearSelectedAddress
          ? null
          : (selectedAddressId ?? this.selectedAddressId),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      operationInProgressId: clearOperationInProgress
          ? null
          : (operationInProgressId ?? this.operationInProgressId),
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    items,
    selectedAddressId,
    isLoading,
    errorMessage,
    operationInProgressId,
    effects,
  ];
}
