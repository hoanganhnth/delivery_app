import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../application/address_form_intent.dart';
import '../../application/address_form_state.dart';

class AddressLocationRequestCard extends StatelessWidget {
  const AddressLocationRequestCard({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final strings = S.of(context);
    return Card(
      margin: EdgeInsets.zero,
      color: scheme.primaryContainer,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: AppRadii.card,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.card),
          child: Row(
            children: [
              if (isLoading)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(Icons.my_location, color: scheme.onPrimaryContainer),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoading
                          ? strings.addressGettingLocation
                          : strings.addressGetCurrentLocation,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (!isLoading) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        strings.addressAutoFillLocation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isLoading)
                Icon(Icons.chevron_right, color: scheme.onPrimaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressFormFields extends StatelessWidget {
  const AddressFormFields({
    super.key,
    required this.labelController,
    required this.recipientController,
    required this.phoneController,
    required this.addressLineController,
    required this.wardController,
    required this.districtController,
    required this.cityController,
    required this.postalCodeController,
    required this.state,
    required this.onIntent,
  });

  final TextEditingController labelController;
  final TextEditingController recipientController;
  final TextEditingController phoneController;
  final TextEditingController addressLineController;
  final TextEditingController wardController;
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;
  final AddressFormViewState state;
  final ValueChanged<AddressFormIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(strings.addressInfo),
        const SizedBox(height: AppSpacing.xs),
        _AddressTextField(
          key: const Key('address_form_label'),
          controller: labelController,
          label: strings.addressLabel,
          hint: strings.addressLabelHint,
          icon: Icons.label_outline,
          error: _errorText(strings, AddressFormField.label),
          onChanged: (value) =>
              onIntent(AddressFormFieldChanged(AddressFormField.label, value)),
        ),
        const SizedBox(height: AppSpacing.sm),
        _AddressTextField(
          key: const Key('address_form_recipient'),
          controller: recipientController,
          label: strings.addressRecipientName,
          hint: strings.addressRecipientHint,
          icon: Icons.person_outline,
          error: _errorText(strings, AddressFormField.recipientName),
          onChanged: (value) => onIntent(
            AddressFormFieldChanged(AddressFormField.recipientName, value),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _AddressTextField(
          key: const Key('address_form_phone'),
          controller: phoneController,
          label: strings.addressPhone,
          hint: strings.addressPhoneHint,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          error: _errorText(strings, AddressFormField.phoneNumber),
          onChanged: (value) => onIntent(
            AddressFormFieldChanged(AddressFormField.phoneNumber, value),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _SectionTitle(strings.addressDetails),
        const SizedBox(height: AppSpacing.xs),
        _AddressTextField(
          key: const Key('address_form_line'),
          controller: addressLineController,
          label: strings.addressLine,
          hint: strings.addressLineHint,
          icon: Icons.home_outlined,
          error: _errorText(strings, AddressFormField.addressLine),
          onChanged: (value) => onIntent(
            AddressFormFieldChanged(AddressFormField.addressLine, value),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _AddressTextField(
                key: const Key('address_form_ward'),
                controller: wardController,
                label: strings.addressWard,
                hint: strings.addressWardHint,
                icon: Icons.location_city_outlined,
                error: _errorText(strings, AddressFormField.ward),
                onChanged: (value) => onIntent(
                  AddressFormFieldChanged(AddressFormField.ward, value),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _AddressTextField(
                key: const Key('address_form_district'),
                controller: districtController,
                label: strings.addressDistrict,
                hint: strings.addressDistrictHint,
                icon: Icons.map_outlined,
                error: _errorText(strings, AddressFormField.district),
                onChanged: (value) => onIntent(
                  AddressFormFieldChanged(AddressFormField.district, value),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _AddressTextField(
                key: const Key('address_form_city'),
                controller: cityController,
                label: strings.addressCity,
                hint: strings.addressCityHint,
                icon: Icons.location_on_outlined,
                error: _errorText(strings, AddressFormField.city),
                onChanged: (value) => onIntent(
                  AddressFormFieldChanged(AddressFormField.city, value),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _AddressTextField(
                key: const Key('address_form_postal_code'),
                controller: postalCodeController,
                label: strings.addressPostalCode,
                hint: strings.addressPostalCodeHint,
                icon: Icons.markunread_mailbox_outlined,
                onChanged: (value) => onIntent(
                  AddressFormFieldChanged(AddressFormField.postalCode, value),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String? _errorText(S strings, AddressFormField field) {
    return switch (state.errorFor(field)) {
      AddressFormValidationIssue.required => switch (field) {
        AddressFormField.label => strings.addressLabelRequired,
        AddressFormField.recipientName => strings.addressRecipientRequired,
        AddressFormField.phoneNumber => strings.addressPhoneRequired,
        AddressFormField.addressLine => strings.addressLineRequired,
        AddressFormField.ward => 'Vui lòng nhập phường/xã',
        AddressFormField.district => 'Vui lòng nhập quận/huyện',
        AddressFormField.city => 'Vui lòng nhập tỉnh/thành phố',
        AddressFormField.postalCode => null,
      },
      AddressFormValidationIssue.invalidPhone => strings.addressPhoneInvalid,
      null => null,
    };
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
  );
}

class _AddressTextField extends StatelessWidget {
  const _AddressTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.error,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? error;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      errorText: error,
      border: const OutlineInputBorder(borderRadius: AppRadii.control),
    ),
  );
}
