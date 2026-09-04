import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../application/address_list_intent.dart';
import '../../application/address_list_state.dart';
import '../components/address_list_card.dart';

/// Pure list rendering: it knows only presentation state and typed intents.
class AddressListView extends StatelessWidget {
  const AddressListView({
    super.key,
    required this.state,
    required this.onIntent,
    this.isSelectMode = false,
  });

  final AddressListViewState state;
  final ValueChanged<AddressListIntent> onIntent;
  final bool isSelectMode;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.myAddresses),
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
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('address_list_add_fab'),
        onPressed: () => onIntent(const AddressListAddRequested()),
        icon: const Icon(Icons.add),
        label: Text(strings.addAddress),
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasLoadError) {
      return _AddressLoadError(
        message: state.errorMessage!,
        onRetry: () => onIntent(const AddressListLoadRequested()),
      );
    }
    if (state.isEmpty) {
      return _AddressEmptyState(
        onAdd: () => onIntent(const AddressListAddRequested()),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => onIntent(const AddressListRefreshRequested()),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.page),
        itemCount: state.items.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final address = state.items[index];
          return AddressListCard(
            address: address,
            isSelected: state.selectedAddressId == address.id,
            isBusy: state.operationInProgressId == address.id,
            isSelectMode: isSelectMode,
            onSelect: () => onIntent(AddressListSelectRequested(address.id)),
            onEdit: () => onIntent(AddressListEditRequested(address.id)),
            onSetDefault: () =>
                onIntent(AddressListSetDefaultRequested(address.id)),
            onDelete: () => onIntent(AddressListDeleteRequested(address.id)),
          );
        },
      ),
    );
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
