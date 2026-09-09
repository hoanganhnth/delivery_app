import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/presentation/components/checkout_components.dart';
import 'package:delivery_app/features/cart/presentation/components/checkout_preview_components.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure checkout rendering. Every customer action is an intent; persistence,
/// price previews, voucher loading and order creation are ViewModel concerns.
class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.state,
    required this.onIntent,
    this.previewMode = false,
  });

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;
  final bool previewMode;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.state.notes);
  }

  @override
  void didUpdateWidget(covariant CheckoutView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_notesController.text != widget.state.notes) {
      _notesController.value = _notesController.value.copyWith(
        text: widget.state.notes,
        selection: TextSelection.collapsed(offset: widget.state.notes.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.previewMode) {
      return Scaffold(
        backgroundColor: PreviewUi.canvas(context),
        appBar: CheckoutPreviewHeader(
          itemCount: widget.state.itemCount,
          onBack: () => widget.onIntent(const CheckoutBackRequested()),
          onCart: () => widget.onIntent(const CheckoutBackRequested()),
        ),
        body: CheckoutPreviewBody(
          state: widget.state,
          notesController: _notesController,
          onIntent: widget.onIntent,
        ),
        bottomNavigationBar:
            widget.state.isCartLoading ||
                widget.state.hasCartError ||
                widget.state.isEmpty
            ? null
            : CheckoutPreviewStickyAction(
                state: widget.state,
                onIntent: widget.onIntent,
              ),
      );
    }
    return Scaffold(
      appBar: AppTopBar(
        title: S.of(context).checkoutTitle,
        leadingKey: const Key('checkout_back'),
        backTooltip: S.of(context).pilotCheckoutClose,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onBack: () => widget.onIntent(const CheckoutBackRequested()),
      ),
      body: CheckoutBody(
        state: widget.state,
        notesController: _notesController,
        onIntent: widget.onIntent,
      ),
      bottomNavigationBar:
          widget.state.isCartLoading ||
              widget.state.hasCartError ||
              widget.state.isEmpty
          ? null
          : CheckoutStickyAction(
              state: widget.state,
              onIntent: widget.onIntent,
            ),
    );
  }
}
