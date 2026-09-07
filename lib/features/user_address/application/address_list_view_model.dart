import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/contracts/session_port_provider.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';
import 'package:delivery_app/features/user_address/application/address_store_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'address_list_effect.dart';
import 'address_list_intent.dart';
import 'address_list_state.dart';
import 'address_list_context.dart';

final addressListViewModelProvider =
    NotifierProvider<AddressListViewModel, AddressListViewState>(
      AddressListViewModel.new,
    );

/// Address-list interaction boundary.
///
/// The legacy address notifier remains the temporary shared-state seam for
/// Checkout/Cart. This ViewModel owns every list interaction and maps that
/// seam into presentation-safe data, so no new page or view reads it directly.
class AddressListViewModel extends Notifier<AddressListViewState> {
  int _nextEffectId = 0;
  AddressListContext _selectionContext = AddressListContext.management;
  final Set<int> _runningOperationIds = <int>{};

  @override
  AddressListViewState build() {
    final initial = ref.read(userAddressListProvider);
    ref.listen<UserAddressListState>(userAddressListProvider, (_, next) {
      if (ref.mounted) _publish(next);
    });
    return _fromLegacy(initial);
  }

  /// Activate the route-specific selection contract upon route entry.
  void activateContext(AddressListContext context) {
    _selectionContext = context;
    final notifier = ref.read(userAddressListProvider.notifier);
    switch (context) {
      case AddressListContext.home:
        notifier.autoSelectDefaultAddress();
      case AddressListContext.checkout:
        notifier.beginCheckoutSelection();
      case AddressListContext.management:
        break;
    }
    _publish(ref.read(userAddressListProvider));
  }

  Future<void> dispatch(AddressListIntent intent) async {
    switch (intent) {
      case AddressListLoadRequested(:final context):
        await _load(context);
      case AddressListRefreshRequested(:final context):
        await _load(context);
      case AddressListSelectRequested(:final addressId, :final context):
        _select(addressId, context);
      case AddressListSetDefaultRequested(:final addressId):
        await _setDefault(addressId);
      case AddressListDeleteRequested(:final addressId):
        _requestDelete(addressId);
      case AddressListDeleteConfirmed(:final addressId):
        await _delete(addressId);
      case AddressListAddRequested():
        _emit(const AddressListNavigateToAdd());
      case AddressListEditRequested(:final addressId):
        if (_findLegacyAddress(addressId) != null) {
          _emit(AddressListNavigateToEdit(addressId));
        }
      case AddressListEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _load(AddressListContext context) async {
    _selectionContext = context;
    final userId = ref.read(sessionPortProvider).current.profileId;
    if (userId == null || userId <= 0) return;
    final notifier = ref.read(userAddressListProvider.notifier);
    await notifier.loadAddresses(userId);
    if (!ref.mounted) return;
    switch (context) {
      case AddressListContext.home:
        notifier.autoSelectDefaultAddress();
      case AddressListContext.checkout:
        notifier.beginCheckoutSelection();
      case AddressListContext.management:
        break;
    }
  }

  void _select(int addressId, AddressListContext context) {
    final address = _findLegacyAddress(addressId);
    if (address == null) return;
    _selectionContext = context;
    final notifier = ref.read(userAddressListProvider.notifier);
    switch (context) {
      case AddressListContext.home:
        notifier.selectHomeAddress(address);
      case AddressListContext.checkout:
        notifier.selectCheckoutAddress(address);
      case AddressListContext.management:
        return;
    }
    _emit(const AddressListNavigateBack());
  }

  void _requestDelete(int addressId) {
    final address = _findLegacyAddress(addressId);
    if (address == null || _runningOperationIds.contains(addressId)) return;
    _emit(AddressListConfirmDelete(_toViewData(address)));
  }

  Future<void> _setDefault(int addressId) async {
    if (!_beginOperation(addressId)) return;
    try {
      final notifier = ref.read(userAddressListProvider.notifier);
      await notifier.setDefaultAddress(addressId);
      if (!ref.mounted) return;
      final operation = ref.read(userAddressListProvider).lastOperation;
      _emit(
        AddressListShowOperationFeedback(
          operation: AddressListOperation.setDefault,
          isSuccess: operation?.isSuccess == true,
          addressLabel: operation?.addressLabel,
        ),
      );
      notifier.clearOperation();
    } finally {
      _endOperation(addressId);
    }
  }

  Future<void> _delete(int addressId) async {
    if (!_beginOperation(addressId)) return;
    try {
      final notifier = ref.read(userAddressListProvider.notifier);
      await notifier.deleteAddress(addressId);
      if (!ref.mounted) return;
      final legacy = ref.read(userAddressListProvider);
      final operation = legacy.lastOperation;
      _emit(
        AddressListShowOperationFeedback(
          operation: AddressListOperation.delete,
          isSuccess: operation?.isSuccess == true,
          addressLabel: operation?.addressLabel,
        ),
      );
      notifier.clearOperation();
    } finally {
      _endOperation(addressId);
    }
  }

  bool _beginOperation(int addressId) {
    if (_runningOperationIds.contains(addressId)) return false;
    _runningOperationIds.add(addressId);
    state = state.copyWith(operationInProgressId: addressId);
    return true;
  }

  void _endOperation(int addressId) {
    _runningOperationIds.remove(addressId);
    if (!ref.mounted) return;
    state = state.copyWith(clearOperationInProgress: true);
  }

  UserAddressEntity? _findLegacyAddress(int id) => ref
      .read(userAddressListProvider)
      .addresses
      .where((address) => address.id == id)
      .firstOrNull;

  void _publish(UserAddressListState legacy) {
    state = _fromLegacy(
      legacy,
      effects: state.effects,
      operationInProgressId: state.operationInProgressId,
    );
  }

  AddressListViewState _fromLegacy(
    UserAddressListState legacy, {
    List<UiEffectEnvelope<AddressListEffect>> effects = const [],
    int? operationInProgressId,
  }) {
    final selectedAddress = switch (_selectionContext) {
      AddressListContext.home => legacy.selectedAddress,
      AddressListContext.checkout => legacy.checkoutSelectedAddress,
      AddressListContext.management => null,
    };
    return AddressListViewState(
      items: List<AddressListItemViewData>.unmodifiable(
        legacy.addresses
            .where((address) => address.id != null)
            .map(_toViewData),
      ),
      selectedAddressId: selectedAddress?.id,
      isLoading: legacy.isLoading,
      errorMessage: legacy.errorMessage,
      operationInProgressId: operationInProgressId,
      effects: effects,
    );
  }

  AddressListItemViewData _toViewData(UserAddressEntity address) =>
      AddressListItemViewData(
        id: address.id!,
        label: address.label,
        recipientName: address.recipientName,
        phoneNumber: address.phoneNumber,
        fullAddress: address.fullAddress,
        isDefault: address.isDefault,
        hasCoordinates: address.hasCoordinates,
      );

  void _emit(AddressListEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
