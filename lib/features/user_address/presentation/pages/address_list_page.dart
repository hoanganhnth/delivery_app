import 'dart:async';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/design_system/components/preview_bottom_navigation.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/address_list_effect.dart';
import '../../application/address_list_context.dart';
import '../../application/address_list_intent.dart';
import '../../application/address_list_state.dart';
import '../../application/address_list_view_model.dart';
import '../views/address_list_view.dart';

/// Riverpod, lifecycle, navigation and dialog adapter for [AddressListView].
class AddressListPage extends ConsumerStatefulWidget {
  const AddressListPage({
    super.key,
    this.selectionContext = AddressListContext.management,
    this.isSelectMode,
  });

  final AddressListContext selectionContext;
  final bool? isSelectMode;

  AddressListContext get effectiveSelectionContext => isSelectMode == null
      ? selectionContext
      : isSelectMode == true
      ? AddressListContext.home
      : AddressListContext.management;

  @override
  ConsumerState<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends ConsumerState<AddressListPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref
            .read(addressListViewModelProvider.notifier)
            .activateContext(widget.effectiveSelectionContext);
        _load();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    if (appState == AppLifecycleState.resumed) _load();
  }

  void _load() => unawaited(
    ref
        .read(addressListViewModelProvider.notifier)
        .dispatch(
          AddressListLoadRequested(context: widget.effectiveSelectionContext),
        ),
  );

  @override
  Widget build(BuildContext context) {
    ref.listen<AddressListViewState>(addressListViewModelProvider, (
      previous,
      next,
    ) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(envelope.id, envelope.effect));
        }
      }
    });
    return AddressListView(
      state: ref.watch(addressListViewModelProvider),
      selectionContext: widget.effectiveSelectionContext,
      previewMode: true,
      // Address management can be opened before the local cart store has
      // been initialized. Keep this route independent from cart I/O.
      cartItemCount: 0,
      onBack: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.main);
        }
      },
      onCart: () => context.go(AppRoutes.cart),
      bottomNavigationBar:
          widget.effectiveSelectionContext == AddressListContext.management
          ? PreviewBottomNavigation(
              currentIndex: 3,
              cartItemCount: 0,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(AppRoutes.main);
                  case 1:
                    context.go(AppRoutes.orders);
                  case 2:
                    context.go(AppRoutes.cart);
                  case 3:
                    context.go(AppRoutes.profile);
                }
              },
            )
          : null,
      onIntent: (intent) => unawaited(
        ref.read(addressListViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(int effectId, AddressListEffect effect) async {
    switch (effect) {
      case AddressListNavigateBack():
        if (mounted && context.canPop()) {
          context.pop();
        }
      case AddressListNavigateToAdd():
        if (mounted) {
          context.pushAddAddress();
        }
      case AddressListNavigateToEdit(:final addressId):
        if (mounted) {
          context.push('${AppRoutes.editAddress}?addressId=$addressId');
        }
      case AddressListConfirmDelete(:final address):
        if (mounted && await _confirmDelete(address.label)) {
          await ref
              .read(addressListViewModelProvider.notifier)
              .dispatch(AddressListDeleteConfirmed(address.id));
        }
      case AddressListShowOperationFeedback(
        :final operation,
        :final isSuccess,
        :final addressLabel,
      ):
        if (mounted) {
          _showOperationFeedback(operation, isSuccess, addressLabel);
        }
    }
    await ref
        .read(addressListViewModelProvider.notifier)
        .dispatch(AddressListEffectConsumed(effectId));
  }

  Future<bool> _confirmDelete(String label) async {
    final strings = S.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (dialog) => AlertDialog(
            title: Text(strings.confirmDeleteAddress),
            content: Text(strings.confirmDeleteAddressMessage(label)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialog, false),
                child: Text(strings.cancelDelete),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialog, true),
                child: Text(strings.confirmDeleteAddressBtn),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showOperationFeedback(
    AddressListOperation operation,
    bool isSuccess,
    String? addressLabel,
  ) {
    switch ((operation, isSuccess)) {
      case (AddressListOperation.delete, true):
        ToastUtils.showAddressDeleteSuccess(
          context,
          addressLabel: addressLabel,
        );
      case (AddressListOperation.delete, false):
        ToastUtils.showAddressDeleteError(context);
      case (AddressListOperation.setDefault, true):
        ToastUtils.showAddressSetDefaultSuccess(
          context,
          addressLabel: addressLabel,
        );
      case (AddressListOperation.setDefault, false):
        ToastUtils.showAddressSetDefaultError(context);
    }
  }
}
