import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../application/address_list_context.dart';
import '../../application/address_list_intent.dart';
import '../../application/address_list_state.dart';
import '../components/address_list_card.dart';
import '../components/address_preview_components.dart';

/// Pure list rendering: it knows only presentation state and typed intents.
class AddressListView extends StatelessWidget {
  const AddressListView({
    super.key,
    required this.state,
    required this.onIntent,
    this.selectionContext = AddressListContext.management,
    this.isSelectMode,
    this.previewMode = false,
    this.bottomNavigationBar,
    this.cartItemCount = 0,
    this.onBack,
    this.onCart,
  });

  final AddressListViewState state;
  final ValueChanged<AddressListIntent> onIntent;
  final AddressListContext selectionContext;
  final bool? isSelectMode;
  final bool previewMode;
  final Widget? bottomNavigationBar;
  final int cartItemCount;
  final VoidCallback? onBack;
  final VoidCallback? onCart;

  AddressListContext get _effectiveSelectionContext => isSelectMode == null
      ? selectionContext
      : isSelectMode == true
      ? AddressListContext.home
      : AddressListContext.management;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final title = _effectiveSelectionContext == AddressListContext.management
        ? strings.myAddresses
        : strings.pilotCheckoutSelectAddress;
    if (previewMode) {
      return Scaffold(
        backgroundColor: PreviewUi.canvas(context),
        appBar: AddressPreviewHeader(
          title: title,
          itemCount: cartItemCount,
          onBack: onBack ?? () => Navigator.of(context).maybePop(),
          onCart: onCart ?? () => Navigator.of(context).maybePop(),
        ),
        body: _body(context),
        bottomNavigationBar: bottomNavigationBar,
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(title),
        actions: [
          IconButton(
            key: const Key('address_list_add_action'),
            tooltip: strings.addAddress,
            icon: const Icon(Icons.add),
            onPressed: () => onIntent(const AddressListAddRequested()),
          ),
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final selectionContext = _effectiveSelectionContext;
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasLoadError) {
      return _AddressLoadError(
        message: state.errorMessage!,
        onRetry: () =>
            onIntent(AddressListLoadRequested(context: selectionContext)),
      );
    }
    if (state.isEmpty) {
      return _AddressEmptyState(
        onAdd: () => onIntent(const AddressListAddRequested()),
      );
    }
    final list = RefreshIndicator(
      onRefresh: () async =>
          onIntent(AddressListRefreshRequested(context: selectionContext)),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: state.items.length + 1,
        separatorBuilder: (_, _) => const SizedBox.shrink(),
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Material(
                color: Theme.of(context).colorScheme.surface,
                child: TextButton.icon(
                  key: const Key('address_list_add_fab'),
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () => onIntent(const AddressListAddRequested()),
                  icon: const Icon(Icons.add_circle_outline),
                  label: Text(S.of(context).addAddress),
                ),
              ),
            );
          }
          final address = state.items[index];
          final isSelected =
              selectionContext != AddressListContext.management &&
              state.selectedAddressId == address.id;
          if (previewMode) {
            return AddressPreviewCard(
              address: address,
              isSelected: isSelected,
              isSelectMode: selectionContext != AddressListContext.management,
              onSelect: () => onIntent(
                AddressListSelectRequested(
                  address.id,
                  context: selectionContext,
                ),
              ),
              onEdit: () => onIntent(AddressListEditRequested(address.id)),
            );
          }
          return AddressListCard(
            address: address,
            isSelected: isSelected,
            isBusy: state.operationInProgressId == address.id,
            isSelectMode: selectionContext != AddressListContext.management,
            onSelect: () => onIntent(
              AddressListSelectRequested(address.id, context: selectionContext),
            ),
            onEdit: () => onIntent(AddressListEditRequested(address.id)),
            onSetDefault: () =>
                onIntent(AddressListSetDefaultRequested(address.id)),
            onDelete: () => onIntent(AddressListDeleteRequested(address.id)),
          );
        },
      ),
    );
    return list;
  }
}

class _AddressEmptyState extends StatelessWidget {
  const _AddressEmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off_outlined, size: 64, color: scheme.primary),
            const SizedBox(height: AppSpacing.lg),
            Text(
              strings.noAddressFound,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              strings.noAddressFoundSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: Text(strings.addFirstAddress),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressLoadError extends StatelessWidget {
  const _AddressLoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 52,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ],
      ),
    ),
  );
}
