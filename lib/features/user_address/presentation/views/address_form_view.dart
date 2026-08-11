import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../application/address_form_intent.dart';
import '../../application/address_form_state.dart';
import '../components/address_form_components.dart';

/// A stateful widget only for native text-field controller lifecycle.
/// It has no I/O, navigation, provider access or business decisions.
class AddressFormView extends StatefulWidget {
  const AddressFormView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final AddressFormViewState state;
  final ValueChanged<AddressFormIntent> onIntent;

  @override
  State<AddressFormView> createState() => _AddressFormViewState();
}

class _AddressFormViewState extends State<AddressFormView> {
  late final TextEditingController _label;
  late final TextEditingController _recipient;
  late final TextEditingController _phone;
  late final TextEditingController _addressLine;
  late final TextEditingController _ward;
  late final TextEditingController _district;
  late final TextEditingController _city;
  late final TextEditingController _postalCode;

  @override
  void initState() {
    super.initState();
    final draft = widget.state.draft;
    _label = TextEditingController(text: draft.label);
    _recipient = TextEditingController(text: draft.recipientName);
    _phone = TextEditingController(text: draft.phoneNumber);
    _addressLine = TextEditingController(text: draft.addressLine);
    _ward = TextEditingController(text: draft.ward);
    _district = TextEditingController(text: draft.district);
    _city = TextEditingController(text: draft.city);
    _postalCode = TextEditingController(text: draft.postalCode);
  }

  @override
  void didUpdateWidget(covariant AddressFormView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final draft = widget.state.draft;
    _sync(_label, draft.label);
    _sync(_recipient, draft.recipientName);
    _sync(_phone, draft.phoneNumber);
    _sync(_addressLine, draft.addressLine);
    _sync(_ward, draft.ward);
    _sync(_district, draft.district);
    _sync(_city, draft.city);
    _sync(_postalCode, draft.postalCode);
  }

  void _sync(TextEditingController controller, String value) {
    if (controller.text == value) return;
    controller.value = controller.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
      composing: TextRange.empty,
    );
  }

  @override
  void dispose() {
    _label.dispose();
    _recipient.dispose();
    _phone.dispose();
    _addressLine.dispose();
    _ward.dispose();
    _district.dispose();
    _city.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.isLoadingInitial) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (widget.state.hasLoadError) {
      return _AddressFormLoadError(
        message: widget.state.loadErrorMessage!,
        onRetry: () => widget.onIntent(const AddressFormInitializeRequested()),
        onBack: () => widget.onIntent(const AddressFormBackRequested()),
      );
    }

    final strings = S.of(context);
    final state = widget.state;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key('address_form_back'),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => widget.onIntent(const AddressFormBackRequested()),
        ),
        title: Text(
          state.isEditing ? strings.addressEditTitle : strings.addressAddTitle,
        ),
        actions: [
          if (state.isEditing)
            IconButton(
              key: const Key('address_form_delete'),
              tooltip: strings.addressDelete,
              icon: const Icon(Icons.delete_outline),
              onPressed: state.isSubmitting
                  ? null
                  : () => widget.onIntent(const AddressFormDeleteRequested()),
            ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.page),
          children: [
            Text(
              strings.addressType,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            _QuickLabelChips(
              selectedLabel: state.draft.label,
              onSelected: (label) => widget.onIntent(
                AddressFormFieldChanged(AddressFormField.label, label),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AddressLocationRequestCard(
              isLoading: state.isResolvingLocation,
              onPressed: () =>
                  widget.onIntent(const AddressFormLocationRequested()),
            ),
            const SizedBox(height: AppSpacing.lg),
            AddressFormFields(
              labelController: _label,
              recipientController: _recipient,
              phoneController: _phone,
              addressLineController: _addressLine,
              wardController: _ward,
              districtController: _district,
              cityController: _city,
              postalCodeController: _postalCode,
              state: state,
              onIntent: widget.onIntent,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: _AddressFormBottomBar(
        state: state,
        onIntent: widget.onIntent,
      ),
    );
  }
}

class _QuickLabelChips extends StatelessWidget {
  const _QuickLabelChips({
    required this.selectedLabel,
    required this.onSelected,
  });

  final String selectedLabel;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.xs,
    runSpacing: AppSpacing.xs,
    children: ['Nhà riêng', 'Công ty', 'Trường học', 'Khác']
        .map(
          (label) => ChoiceChip(
            label: Text(label),
            selected: selectedLabel == label,
            onSelected: (selected) {
              if (selected) onSelected(label);
            },
          ),
        )
        .toList(growable: false),
  );
}

class _AddressFormBottomBar extends StatelessWidget {
  const _AddressFormBottomBar({required this.state, required this.onIntent});

  final AddressFormViewState state;
  final ValueChanged<AddressFormIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Material(
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.page),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: const Text('Đặt làm địa chỉ mặc định'),
                value: state.draft.isDefault,
                onChanged: state.isSubmitting
                    ? null
                    : (value) => onIntent(AddressFormDefaultChanged(value)),
              ),
              const SizedBox(height: AppSpacing.xs),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  key: const Key('address_form_submit'),
                  onPressed: state.isSubmitting
                      ? null
                      : () => onIntent(const AddressFormSubmitRequested()),
                  child: state.isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          state.isEditing
                              ? strings.addressSave
                              : strings.addressAdd,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressFormLoadError extends StatelessWidget {
  const _AddressFormLoadError({
    required this.message,
    required this.onRetry,
    required this.onBack,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack,
      ),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
    ),
  );
}
