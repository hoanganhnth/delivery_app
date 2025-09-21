import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:delivery_app/core/presentation/widgets/toast/toast_utils.dart';
import 'package:delivery_app/core/routing/navigation_helper.dart';
import '../../domain/entities/user_address_entity.dart';
import '../../data/dtos/user_address_request_dto.dart';
import '../providers/user_address_providers.dart';

class AddEditAddressScreen extends ConsumerStatefulWidget {
  final UserAddressEntity? address; // null for add, non-null for edit

  const AddEditAddressScreen({super.key, this.address});

  @override
  ConsumerState<AddEditAddressScreen> createState() =>
      _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends ConsumerState<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  late final TextEditingController _labelController;
  late final TextEditingController _addressLineController;
  late final TextEditingController _wardController;
  late final TextEditingController _districtController;
  late final TextEditingController _cityController;
  late final TextEditingController _postalCodeController;

  bool _isDefault = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if editing
    final address = widget.address;
    _labelController = TextEditingController(text: address?.label ?? '');
    _addressLineController = TextEditingController(
      text: address?.addressLine ?? '',
    );
    _wardController = TextEditingController(text: address?.ward ?? '');
    _districtController = TextEditingController(text: address?.district ?? '');
    _cityController = TextEditingController(text: address?.city ?? '');
    _postalCodeController = TextEditingController(
      text: address?.postalCode ?? '',
    );
    _isDefault = address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressLineController.dispose();
    _wardController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.address != null;

  @override
  Widget build(BuildContext context) {
    // Listen to form state changes for toast notifications
    ref.listen<AsyncValue<UserAddressEntity?>>(addressFormProvider, (
      previous,
      next,
    ) {
      next.when(
        data: (address) {
          if (previous?.isLoading == true && address != null) {
            // Show success toast
            if (_isEditing) {
              ToastUtils.showAddressUpdateSuccess(
                context,
                addressLabel: address.label,
              );
            } else {
              ToastUtils.showAddressAddSuccess(
                context,
                addressLabel: address.label,
              );
            }
            // Navigate back to address list
            // call get all restaruants
            final user = ref.read(profileStateProvider).user;
            if (user?.id != null) {
              ref
                  .read(userAddressListProvider.notifier)
                  .loadAddresses(user!.id!);
            }
            context.goBack();
          }
        },
        loading: () {
          // Loading state handled by _isLoading
        },
        error: (error, stackTrace) {
          if (previous?.isLoading == true) {
            // Show error toast
            if (_isEditing) {
              ToastUtils.showAddressUpdateError(
                context,
                message: error.toString(),
              );
            } else {
              ToastUtils.showAddressAddError(
                context,
                message: error.toString(),
              );
            }
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Sửa địa chỉ' : 'Thêm địa chỉ mới'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: _isEditing
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmation(),
                ),
              ]
            : null,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(ResponsiveSize.m),
          children: [_buildFormFields()],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label field
        _buildTextFormField(
          controller: _labelController,
          label: 'Nhãn địa chỉ',
          hintText: 'Ví dụ: Nhà riêng, Công ty...',
          icon: Icons.label,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập nhãn địa chỉ';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // Address line field
        _buildTextFormField(
          controller: _addressLineController,
          label: 'Địa chỉ chi tiết',
          hintText: 'Số nhà, tên đường...',
          icon: Icons.home,
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập địa chỉ chi tiết';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // Ward field
        _buildTextFormField(
          controller: _wardController,
          label: 'Phường/Xã',
          hintText: 'Nhập phường/xã',
          icon: Icons.location_city,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập phường/xã';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // District field
        _buildTextFormField(
          controller: _districtController,
          label: 'Quận/Huyện',
          hintText: 'Nhập quận/huyện',
          icon: Icons.location_city,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập quận/huyện';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // City field
        _buildTextFormField(
          controller: _cityController,
          label: 'Tỉnh/Thành phố',
          hintText: 'Nhập tỉnh/thành phố',
          icon: Icons.location_city,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập tỉnh/thành phố';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // Postal code field (optional)
        _buildTextFormField(
          controller: _postalCodeController,
          label: 'Mã bưu điện (Tùy chọn)',
          hintText: 'Nhập mã bưu điện',
          icon: Icons.markunread_mailbox,
          keyboardType: TextInputType.number,
        ),

        SizedBox(height: ResponsiveSize.l),

        // Set as default checkbox
        CheckboxListTile(
          title: const Text('Đặt làm địa chỉ mặc định'),
          subtitle: const Text('Địa chỉ này sẽ được chọn tự động khi đặt hàng'),
          value: _isDefault,
          onChanged: (value) {
            setState(() {
              _isDefault = value ?? false;
            });
          },
          activeColor: Colors.orange,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.orange),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    final formState = ref.watch(addressFormProvider);
    final isLoading = formState.isLoading;

    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 6,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Delete button (only when editing)
            if (_isEditing) ...[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isLoading ? null : () => _showDeleteConfirmation(),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Xóa', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(vertical: ResponsiveSize.m),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveSize.m),
            ],

            // Save button
            Expanded(
              flex: _isEditing ? 1 : 2,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : _saveAddress,
                icon: isLoading
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(_isEditing ? 'Lưu' : 'Thêm địa chỉ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: ResponsiveSize.m),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = ref.read(profileStateProvider).user;
    if (user?.id == null) {
      ToastUtils.showAddressAddError(
        context,
        message: 'Không tìm thấy thông tin người dùng',
      );
      return;
    }

    final requestDto = UserAddressRequestDto(
      label: _labelController.text.trim(),
      addressLine: _addressLineController.text.trim(),
      ward: _wardController.text.trim(),
      district: _districtController.text.trim(),
      city: _cityController.text.trim(),
      postalCode: _postalCodeController.text.trim().isEmpty
          ? null
          : _postalCodeController.text.trim(),
      isDefault: _isDefault,
    );

    if (_isEditing) {
      // Update existing address
      await ref
          .read(addressFormProvider.notifier)
          .updateAddress(widget.address!.id!, requestDto);
    } else {
      // Create new address
      await ref
          .read(addressFormProvider.notifier)
          .createAddress(user!.id!, requestDto);
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text(
          'Bạn có chắc muốn xóa địa chỉ "${widget.address?.label}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final success = await ref
                  .read(userAddressListProvider.notifier)
                  .deleteAddress(widget.address!.id!);

              if (mounted) {
                if (success) {
                  ToastUtils.showAddressDeleteSuccess(
                    context,
                    addressLabel: widget.address?.label,
                  );
                  context.goBack();
                } else {
                  ToastUtils.showAddressDeleteError(context);
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
