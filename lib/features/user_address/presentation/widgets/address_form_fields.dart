import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';

class AddressFormFields extends StatelessWidget {
  final TextEditingController labelController;
  final TextEditingController recipientNameController;
  final TextEditingController phoneController;
  final TextEditingController addressLineController;
  final TextEditingController wardController;
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;
  final AppColors colors;

  const AddressFormFields({
    super.key,
    required this.labelController,
    required this.recipientNameController,
    required this.phoneController,
    required this.addressLineController,
    required this.wardController,
    required this.districtController,
    required this.cityController,
    required this.postalCodeController,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(s.addressInfo, colors),
        SizedBox(height: ResponsiveSize.s),
        _buildTextFormField(
          controller: labelController,
          label: s.addressLabel,
          hintText: s.addressLabelHint,
          icon: Icons.label_outline,
          validator: (value) => (value == null || value.trim().isEmpty) ? s.addressLabelRequired : null,
          colors: colors,
        ),
        SizedBox(height: ResponsiveSize.m),
        _buildTextFormField(
          controller: recipientNameController,
          label: s.addressRecipientName,
          hintText: s.addressRecipientHint,
          icon: Icons.person_outline,
          validator: (value) => (value == null || value.trim().isEmpty) ? s.addressRecipientRequired : null,
          colors: colors,
        ),
        SizedBox(height: ResponsiveSize.m),
        _buildTextFormField(
          controller: phoneController,
          label: s.addressPhone,
          hintText: s.addressPhoneHint,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.trim().isEmpty) return s.addressPhoneRequired;
            if (value.trim().length < 10) return s.addressPhoneInvalid;
            return null;
          },
          colors: colors,
        ),
        SizedBox(height: ResponsiveSize.l),
        _buildSectionTitle(s.addressDetails, colors),
        SizedBox(height: ResponsiveSize.s),
        _buildTextFormField(
          controller: addressLineController,
          label: s.addressLine,
          hintText: s.addressLineHint,
          icon: Icons.home_outlined,
          validator: (value) => (value == null || value.trim().isEmpty) ? s.addressLineRequired : null,
          colors: colors,
        ),
        SizedBox(height: ResponsiveSize.m),
        Row(
          children: [
            Expanded(
              child: _buildTextFormField(
                controller: wardController,
                label: s.addressWard,
                hintText: s.addressWardHint,
                icon: Icons.location_city_outlined,
                colors: colors,
              ),
            ),
            SizedBox(width: ResponsiveSize.m),
            Expanded(
              child: _buildTextFormField(
                controller: districtController,
                label: s.addressDistrict,
                hintText: s.addressDistrictHint,
                icon: Icons.map_outlined,
                colors: colors,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveSize.m),
        Row(
          children: [
            Expanded(
              child: _buildTextFormField(
                controller: cityController,
                label: s.addressCity,
                hintText: s.addressCityHint,
                icon: Icons.location_on_outlined,
                colors: colors,
              ),
            ),
            SizedBox(width: ResponsiveSize.m),
            Expanded(
              child: _buildTextFormField(
                controller: postalCodeController,
                label: s.addressPostalCode,
                hintText: s.addressPostalCodeHint,
                icon: Icons.markunread_mailbox_outlined,
                isRequired: false,
                colors: colors,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, AppColors colors) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveSize.fontL,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required AppColors colors,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool isRequired = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        fontSize: ResponsiveSize.fontM,
        color: colors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: colors.textSecondary, size: 22.w),
        filled: true,
        fillColor: colors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          borderSide: BorderSide(color: colors.border.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          borderSide: BorderSide(color: colors.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.m,
          vertical: ResponsiveSize.m,
        ),
      ),
    );
  }
}
