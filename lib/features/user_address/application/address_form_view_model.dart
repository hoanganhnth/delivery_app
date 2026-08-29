import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/services/location/_riverpod/location_service_provider.dart';
import 'package:delivery_app/core/contracts/session_port_provider.dart';
import 'package:delivery_app/features/user_address/domain/entities/address_upsert_command.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/user_address/di/user_address_di_providers.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'address_form_effect.dart';
import 'address_form_intent.dart';
import 'address_form_state.dart';

final addressFormViewModelProvider =
    NotifierProvider.family<
      AddressFormViewModel,
      AddressFormViewState,
      AddressFormTarget
    >((target) => AddressFormViewModel(target));

/// Owns form input, validation, location lookup and address mutations.
///
/// The existing address-list notifier is updated only as a compatibility
/// projection for Checkout and Cart until they consume an address port.
class AddressFormViewModel extends Notifier<AddressFormViewState> {
  AddressFormViewModel(this._target);

  final AddressFormTarget _target;
  int _nextEffectId = 0;

  @override
  AddressFormViewState build() {
    final initial = _target.initialAddress;
    return AddressFormViewState(
      addressId: _target.addressId ?? initial?.id,
      draft: initial == null
          ? const AddressFormDraft()
          : AddressFormDraft.fromAddress(initial),
    );
  }

  Future<void> dispatch(AddressFormIntent intent) async {
    switch (intent) {
      case AddressFormInitializeRequested():
        await _initialize();
      case AddressFormFieldChanged(:final field, :final value):
        _changeField(field, value);
      case AddressFormDefaultChanged(:final isDefault):
        state = state.copyWith(
          draft: state.draft.copyWith(isDefault: isDefault),
        );
      case AddressFormLocationRequested():
        await _resolveLocation();
      case AddressFormSubmitRequested():
        await _submit();
      case AddressFormDeleteRequested():
        if (state.addressId != null && !state.isSubmitting) {
          _emit(AddressFormConfirmDelete(state.draft.label));
        }
      case AddressFormDeleteConfirmed():
        await _delete();
      case AddressFormBackRequested():
        _emit(const AddressFormNavigateBack());
      case AddressFormEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _initialize() async {
    if (_target.initialAddress != null ||
        state.addressId == null ||
        state.isLoadingInitial) {
      return;
    }
    state = state.copyWith(isLoadingInitial: true, clearLoadError: true);
    final result = await ref
        .read(getAddressByIdUseCaseProvider)
        .call(state.addressId!);
    if (!ref.mounted) return;
    result.fold(
      (failure) => state = state.copyWith(
        isLoadingInitial: false,
        loadErrorMessage: failure.message,
      ),
      (address) => state = state.copyWith(
        addressId: address.id,
        draft: AddressFormDraft.fromAddress(address),
        isLoadingInitial: false,
        clearLoadError: true,
      ),
    );
  }

  void _changeField(AddressFormField field, String value) {
    final draft = switch (field) {
      AddressFormField.label => state.draft.copyWith(label: value),
      AddressFormField.recipientName => state.draft.copyWith(
        recipientName: value,
      ),
      AddressFormField.phoneNumber => state.draft.copyWith(phoneNumber: value),
      AddressFormField.addressLine => state.draft.copyWith(addressLine: value),
      AddressFormField.ward => state.draft.copyWith(ward: value),
      AddressFormField.district => state.draft.copyWith(district: value),
      AddressFormField.city => state.draft.copyWith(city: value),
      AddressFormField.postalCode => state.draft.copyWith(postalCode: value),
    };
    state = state.copyWith(
      draft: draft,
      validationErrors: state.validationErrors
          .where((error) => error.field != field)
          .toList(growable: false),
    );
  }

  Future<void> _resolveLocation() async {
    if (state.isResolvingLocation) return;
    state = state.copyWith(isResolvingLocation: true);
    try {
      final service = ref.read(locationServiceProvider);
      final position = await service.getCurrentPosition();
      if (!ref.mounted || position == null) return;
      final formattedAddress = await service.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (!ref.mounted) return;
      state = state.copyWith(
        isResolvingLocation: false,
        draft: state.draft.copyWith(
          latitude: position.latitude,
          longitude: position.longitude,
          addressLine: state.draft.addressLine.trim().isEmpty
              ? formattedAddress
              : state.draft.addressLine,
        ),
      );
    } catch (_) {
      if (!ref.mounted) return;
      _emit(const AddressFormShowMessage('Không thể lấy vị trí hiện tại.'));
    } finally {
      if (ref.mounted && state.isResolvingLocation) {
        state = state.copyWith(isResolvingLocation: false);
      }
    }
  }

  Future<void> _submit() async {
    if (state.isSubmitting || state.isLoadingInitial) return;
    final validationErrors = _validate(state.draft);
    if (validationErrors.isNotEmpty) {
      state = state.copyWith(validationErrors: validationErrors);
      return;
    }

    state = state.copyWith(isSubmitting: true);
    final request = _requestFrom(state.draft);
    final addressId = state.addressId;
    if (addressId == null) {
      final userId = ref.read(sessionPortProvider).current.profileId;
      if (userId == null || userId <= 0) {
        _submitFailure(AddressFormOperation.create);
        return;
      }
      final result = await ref
          .read(createAddressUseCaseProvider)
          .call(userId, request);
      if (!ref.mounted) return;
      result.fold(
        (_) => _submitFailure(AddressFormOperation.create),
        (address) => _submitSuccess(AddressFormOperation.create, address),
      );
      return;
    }

    final result = await ref
        .read(updateAddressUseCaseProvider)
        .call(addressId, request);
    if (!ref.mounted) return;
    result.fold(
      (_) => _submitFailure(AddressFormOperation.update),
      (address) => _submitSuccess(AddressFormOperation.update, address),
    );
  }

  Future<void> _delete() async {
    final addressId = state.addressId;
    if (addressId == null || state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true);
    final result = await ref.read(deleteAddressUseCaseProvider).call(addressId);
    if (!ref.mounted) return;
    result.fold((_) => _deleteFailure(), (didDelete) {
      if (!didDelete) {
        _deleteFailure();
        return;
      }
      _reloadLegacyProjection(clearSelectionForAddressId: addressId);
      state = state.copyWith(isSubmitting: false);
      _emit(
        AddressFormShowOperationFeedback(
          operation: AddressFormOperation.delete,
          isSuccess: true,
          addressLabel: state.draft.label,
        ),
      );
      _emit(const AddressFormNavigateBack());
    });
  }

  void _submitSuccess(
    AddressFormOperation operation,
    UserAddressEntity address,
  ) {
    _reloadLegacyProjection();
    state = state.copyWith(
      addressId: address.id,
      draft: AddressFormDraft.fromAddress(address),
      isSubmitting: false,
      validationErrors: const [],
    );
    _emit(
      AddressFormShowOperationFeedback(
        operation: operation,
        isSuccess: true,
        addressLabel: address.label,
      ),
    );
    _emit(const AddressFormNavigateBack());
  }

  void _submitFailure(AddressFormOperation operation) {
    if (!ref.mounted) return;
    state = state.copyWith(isSubmitting: false);
    _emit(
      AddressFormShowOperationFeedback(operation: operation, isSuccess: false),
    );
  }

  void _deleteFailure() {
    if (!ref.mounted) return;
    state = state.copyWith(isSubmitting: false);
    _emit(
      const AddressFormShowOperationFeedback(
        operation: AddressFormOperation.delete,
        isSuccess: false,
      ),
    );
  }

  void _reloadLegacyProjection({int? clearSelectionForAddressId}) {
    final userId = ref.read(sessionPortProvider).current.profileId;
    if (userId == null || userId <= 0) return;
    final notifier = ref.read(userAddressListProvider.notifier);
    if (clearSelectionForAddressId != null &&
        ref.read(userAddressListProvider).selectedAddress?.id ==
            clearSelectionForAddressId) {
      notifier.selectAddress(null);
    }
    // This must remain asynchronous and independent from the completed form
    // request. Checkout can keep rendering its last stable selection meanwhile.
    notifier
        .loadAddresses(userId)
        .then((_) => notifier.autoSelectDefaultAddress());
  }

  List<AddressFormFieldError> _validate(AddressFormDraft draft) {
    final errors = <AddressFormFieldError>[];
    void required(AddressFormField field, String value) {
      if (value.trim().isEmpty) {
        errors.add(
          AddressFormFieldError(
            field: field,
            issue: AddressFormValidationIssue.required,
          ),
        );
      }
    }

    required(AddressFormField.label, draft.label);
    required(AddressFormField.recipientName, draft.recipientName);
    required(AddressFormField.phoneNumber, draft.phoneNumber);
    if (draft.phoneNumber.trim().isNotEmpty &&
        draft.phoneNumber.trim().length < 10) {
      errors.add(
        const AddressFormFieldError(
          field: AddressFormField.phoneNumber,
          issue: AddressFormValidationIssue.invalidPhone,
        ),
      );
    }
    required(AddressFormField.addressLine, draft.addressLine);
    required(AddressFormField.ward, draft.ward);
    required(AddressFormField.district, draft.district);
    required(AddressFormField.city, draft.city);
    return List<AddressFormFieldError>.unmodifiable(errors);
  }

  AddressUpsertCommand _requestFrom(AddressFormDraft draft) =>
      AddressUpsertCommand(
        label: draft.label.trim(),
        recipientName: draft.recipientName.trim(),
        phoneNumber: draft.phoneNumber.trim(),
        addressLine: draft.addressLine.trim(),
        ward: draft.ward.trim(),
        district: draft.district.trim(),
        city: draft.city.trim(),
        postalCode: draft.postalCode.trim(),
        latitude: draft.latitude,
        longitude: draft.longitude,
        isDefault: draft.isDefault,
      );

  void _emit(AddressFormEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
