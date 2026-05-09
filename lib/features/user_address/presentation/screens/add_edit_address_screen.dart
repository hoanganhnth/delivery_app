import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';

import '../../domain/entities/user_address_entity.dart';
import '../../data/dtos/user_address_request_dto.dart';
import '../providers/providers.dart';
import '../widgets/address_form_fields.dart';
import '../widgets/address_location_picker.dart';
import '../widgets/address_bottom_actions.dart';

class AddEditAddressScreen extends ConsumerStatefulWidget {
  final UserAddressEntity? address;

  const AddEditAddressScreen({super.key, this.address});

  @override
  ConsumerState<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends ConsumerState<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _labelController;
  late final TextEditingController _recipientNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressLineController;
  late final TextEditingController _wardController;
  late final TextEditingController _districtController;
  late final TextEditingController _cityController;
  late final TextEditingController _postalCodeController;

  bool _isDefault = false;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _labelController = TextEditingController(text: a?.label ?? '');
    _recipientNameController = TextEditingController(text: a?.recipientName ?? '');
    _phoneController = TextEditingController(text: a?.phoneNumber ?? '');
    _addressLineController = TextEditingController(text: a?.addressLine ?? '');
    _wardController = TextEditingController(text: a?.ward ?? '');
    _districtController = TextEditingController(text: a?.district ?? '');
    _cityController = TextEditingController(text: a?.city ?? '');
    _postalCodeController = TextEditingController(text: a?.postalCode ?? '');
    _isDefault = a?.isDefault ?? false;
    _latitude = a?.latitude;
    _longitude = a?.longitude;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _recipientNameController.dispose();
    _phoneController.dispose();
    _addressLineController.dispose();
    _wardController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.address != null;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    
    final dto = UserAddressRequestDto(
      label: _labelController.text.trim(),
      recipientName: _recipientNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      addressLine: _addressLineController.text.trim(),
      ward: _wardController.text.trim(),
      district: _districtController.text.trim(),
      city: _cityController.text.trim(),
      postalCode: _postalCodeController.text.trim(),
      isDefault: _isDefault,
      latitude: _latitude,
      longitude: _longitude,
    );
    
    if (_isEditing) {
      ref.read(addressFormProvider.notifier).updateAddress(widget.address!.id!, dto);
    } else {
      final user = ref.read(profileProvider).user;
      if (user?.id != null) {
        ref.read(addressFormProvider.notifier).createAddress(user!.id!, dto);
      }
    }
  }

  void _showDeleteConfirmation() {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.addressDelete),
        content: const Text('Bạn có chắc chắn muốn xóa địa chỉ này?'), 
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'), 
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(userAddressListProvider.notifier).deleteAddress(widget.address!.id!);
              context.pop(); 
            },
            child: Text(s.addressDelete, style: TextStyle(color: ref.colors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLabelChips() {
    final defaultLabels = ['Nhà riêng', 'Công ty', 'Trường học', 'Khác'];

    return Wrap(
      spacing: ResponsiveSize.s,
      runSpacing: ResponsiveSize.s,
      children: defaultLabels.map((label) {
        final isSelected = _labelController.text == label;
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _labelController.text = label;
              });
            }
          },
          backgroundColor: ref.colors.cardBackground,
          selectedColor: ref.colors.primary.withValues(alpha: 0.1),
          labelStyle: TextStyle(
            color: isSelected ? ref.colors.primary : ref.colors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            side: BorderSide(
              color: isSelected
                  ? ref.colors.primary
                  : ref.colors.border.withValues(alpha: 0.5),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = ref.colors;
    final formState = ref.watch(addressFormProvider);

    ref.listen<AsyncValue<UserAddressEntity?>>(addressFormProvider, (previous, next) {
      next.when(
        data: (address) {
          if (previous?.isLoading == true && address != null) {
            if (_isEditing) {
              ToastUtils.showAddressUpdateSuccess(context, addressLabel: address.label);
            } else {
              ToastUtils.showAddressAddSuccess(context, addressLabel: address.label);
            }
            final user = ref.read(profileProvider).user;
            if (user?.id != null) {
              ref.read(userAddressListProvider.notifier).loadAddresses(user!.id!);
            }
            context.pop();
          }
        },
        loading: () {},
        error: (error, _) {
          if (previous?.isLoading == true) {
            if (_isEditing) {
              ToastUtils.showAddressUpdateError(context, message: error.toString());
            } else {
              ToastUtils.showAddressAddError(context, message: error.toString());
            }
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          _isEditing ? s.addressEditTitle : s.addressAddTitle,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colors.primaryDark, colors.primary],
            ),
          ),
        ),
        actions: _isEditing
            ? [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.white),
                  ),
                  onPressed: _showDeleteConfirmation,
                ),
                SizedBox(width: ResponsiveSize.s),
              ]
            : null,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(ResponsiveSize.m),
          children: [
            Text(
              s.addressType,
              style: TextStyle(
                fontSize: ResponsiveSize.fontL,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: ResponsiveSize.s),
            _buildQuickLabelChips(),
            SizedBox(height: ResponsiveSize.l),

            AddressLocationPicker(
              colors: colors,
              onLocationSelected: (lat, lng, addressLine, city) {
                setState(() {
                  _latitude = lat;
                  _longitude = lng;
                  if (_addressLineController.text.isEmpty) _addressLineController.text = addressLine;
                  if (_cityController.text.isEmpty) _cityController.text = city;
                });
              },
            ),
            SizedBox(height: ResponsiveSize.l),
            AddressFormFields(
              labelController: _labelController,
              recipientNameController: _recipientNameController,
              phoneController: _phoneController,
              addressLineController: _addressLineController,
              wardController: _wardController,
              districtController: _districtController,
              cityController: _cityController,
              postalCodeController: _postalCodeController,
              colors: colors,
            ),
            SizedBox(height: ResponsiveSize.xxl),
          ],
        ),
      ),
      bottomNavigationBar: AddressBottomActions(
        colors: colors,
        isEditing: _isEditing,
        isDefault: _isDefault,
        isSubmitting: formState.isLoading,
        onDefaultChanged: (val) => setState(() => _isDefault = val),
        onSave: _submitForm,
      ),
    );
  }
}
