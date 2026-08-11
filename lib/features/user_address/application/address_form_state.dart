import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:equatable/equatable.dart';

import 'address_form_effect.dart';
import 'address_form_intent.dart';

/// Input supplied by compatibility routes or by a new typed route.
final class AddressFormTarget extends Equatable {
  const AddressFormTarget({this.addressId, this.initialAddress});

  final int? addressId;
  final UserAddressEntity? initialAddress;

  bool get isEditing => addressId != null || initialAddress?.id != null;

  @override
  List<Object?> get props => [addressId, initialAddress];
}

final class AddressFormDraft extends Equatable {
  const AddressFormDraft({
    this.label = '',
    this.recipientName = '',
    this.phoneNumber = '',
    this.addressLine = '',
    this.ward = '',
    this.district = '',
    this.city = '',
    this.postalCode = '',
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  final String label;
  final String recipientName;
  final String phoneNumber;
  final String addressLine;
  final String ward;
  final String district;
  final String city;
  final String postalCode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  factory AddressFormDraft.fromAddress(UserAddressEntity address) =>
      AddressFormDraft(
        label: address.label,
        recipientName: address.recipientName,
        phoneNumber: address.phoneNumber,
        addressLine: address.addressLine,
        ward: address.ward,
        district: address.district,
        city: address.city,
        postalCode: address.postalCode ?? '',
        latitude: address.latitude,
        longitude: address.longitude,
        isDefault: address.isDefault,
      );

  AddressFormDraft copyWith({
    String? label,
    String? recipientName,
    String? phoneNumber,
    String? addressLine,
    String? ward,
    String? district,
    String? city,
    String? postalCode,
    double? latitude,
    bool clearLatitude = false,
    double? longitude,
    bool clearLongitude = false,
    bool? isDefault,
  }) {
    return AddressFormDraft(
      label: label ?? this.label,
      recipientName: recipientName ?? this.recipientName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine: addressLine ?? this.addressLine,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      latitude: clearLatitude ? null : (latitude ?? this.latitude),
      longitude: clearLongitude ? null : (longitude ?? this.longitude),
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
    label,
    recipientName,
    phoneNumber,
    addressLine,
    ward,
    district,
    city,
    postalCode,
    latitude,
    longitude,
    isDefault,
  ];
}

enum AddressFormValidationIssue { required, invalidPhone }

final class AddressFormFieldError extends Equatable {
  const AddressFormFieldError({required this.field, required this.issue});

  final AddressFormField field;
  final AddressFormValidationIssue issue;

  @override
  List<Object?> get props => [field, issue];
}

final class AddressFormViewState extends Equatable {
  const AddressFormViewState({
    this.addressId,
    this.draft = const AddressFormDraft(),
    this.isLoadingInitial = false,
    this.isSubmitting = false,
    this.isResolvingLocation = false,
    this.loadErrorMessage,
    this.validationErrors = const <AddressFormFieldError>[],
    this.effects = const <UiEffectEnvelope<AddressFormEffect>>[],
  });

  final int? addressId;
  final AddressFormDraft draft;
  final bool isLoadingInitial;
  final bool isSubmitting;
  final bool isResolvingLocation;
  final String? loadErrorMessage;
  final List<AddressFormFieldError> validationErrors;
  final List<UiEffectEnvelope<AddressFormEffect>> effects;

  bool get isEditing => addressId != null;
  bool get hasLoadError => loadErrorMessage != null;

  AddressFormValidationIssue? errorFor(AddressFormField field) =>
      validationErrors
          .where((error) => error.field == field)
          .firstOrNull
          ?.issue;

  AddressFormViewState copyWith({
    int? addressId,
    bool clearAddressId = false,
    AddressFormDraft? draft,
    bool? isLoadingInitial,
    bool? isSubmitting,
    bool? isResolvingLocation,
    String? loadErrorMessage,
    bool clearLoadError = false,
    List<AddressFormFieldError>? validationErrors,
    List<UiEffectEnvelope<AddressFormEffect>>? effects,
  }) {
    return AddressFormViewState(
      addressId: clearAddressId ? null : (addressId ?? this.addressId),
      draft: draft ?? this.draft,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isResolvingLocation: isResolvingLocation ?? this.isResolvingLocation,
      loadErrorMessage: clearLoadError
          ? null
          : (loadErrorMessage ?? this.loadErrorMessage),
      validationErrors: validationErrors ?? this.validationErrors,
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    addressId,
    draft,
    isLoadingInitial,
    isSubmitting,
    isResolvingLocation,
    loadErrorMessage,
    validationErrors,
    effects,
  ];
}
