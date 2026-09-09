import 'dart:async';

import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/address_form_effect.dart';
import '../../application/address_form_intent.dart';
import '../../application/address_form_state.dart';
import '../../application/address_form_view_model.dart';
import '../views/address_form_view.dart';

/// Adapter for form side effects. The form view remains rendering-only.
class AddressFormPage extends ConsumerStatefulWidget {
  const AddressFormPage({super.key, required this.target});

  final AddressFormTarget target;

  @override
  ConsumerState<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends ConsumerState<AddressFormPage> {
  late final NotifierProvider<AddressFormViewModel, AddressFormViewState>
  _provider = addressFormViewModelProvider(widget.target);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(_provider.notifier)
            .dispatch(const AddressFormInitializeRequested()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AddressFormViewState>(_provider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(envelope.id, envelope.effect));
        }
      }
    });
    return AddressFormView(
      state: ref.watch(_provider),
      onCart: () => context.go(AppRoutes.cart),
      onIntent: (intent) =>
          unawaited(ref.read(_provider.notifier).dispatch(intent)),
    );
  }

  Future<void> _handleEffect(int effectId, AddressFormEffect effect) async {
    switch (effect) {
      case AddressFormNavigateBack():
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      case AddressFormConfirmDelete(:final addressLabel):
        if (mounted && await _confirmDelete(addressLabel)) {
          await ref
              .read(_provider.notifier)
              .dispatch(const AddressFormDeleteConfirmed());
        }
      case AddressFormShowOperationFeedback(
        :final operation,
        :final isSuccess,
        :final addressLabel,
        :final message,
      ):
        if (mounted) {
          _showOperationFeedback(operation, isSuccess, addressLabel, message);
        }
      case AddressFormShowMessage(:final message):
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
    }
    await ref
        .read(_provider.notifier)
        .dispatch(AddressFormEffectConsumed(effectId));
  }

  Future<bool> _confirmDelete(String addressLabel) async =>
      await showDialog<bool>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: const Text('Xóa địa chỉ'),
          content: Text('Bạn có chắc chắn muốn xóa địa chỉ "$addressLabel"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialog, true),
              child: const Text('Xóa'),
            ),
          ],
        ),
      ) ??
      false;

  void _showOperationFeedback(
    AddressFormOperation operation,
    bool isSuccess,
    String? label,
    String? message,
  ) {
    switch ((operation, isSuccess)) {
      case (AddressFormOperation.create, true):
        ToastUtils.showAddressAddSuccess(context, addressLabel: label);
      case (AddressFormOperation.create, false):
        ToastUtils.showAddressAddError(context, message: message);
      case (AddressFormOperation.update, true):
        ToastUtils.showAddressUpdateSuccess(context, addressLabel: label);
      case (AddressFormOperation.update, false):
        ToastUtils.showAddressUpdateError(context, message: message);
      case (AddressFormOperation.delete, true):
        ToastUtils.showAddressDeleteSuccess(context, addressLabel: label);
      case (AddressFormOperation.delete, false):
        ToastUtils.showAddressDeleteError(context, message: message);
    }
  }
}
