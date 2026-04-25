import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../location/presentation/providers/location_providers.dart';
import '../../domain/entities/user_address_entity.dart';
import '../../data/dtos/user_address_request_dto.dart';
import '../providers/providers.dart';

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
  late final TextEditingController _recipientNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressLineController;
  late final TextEditingController _wardController;
  late final TextEditingController _districtController;
  late final TextEditingController _cityController;
  late final TextEditingController _postalCodeController;

  bool _isDefault = false;
  
  // Coordinates from GPS location
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if editing
    final address = widget.address;
    _labelController = TextEditingController(text: address?.label ?? '');
    _recipientNameController = TextEditingController(text: address?.recipientName ?? '');
    _phoneController = TextEditingController(text: address?.phoneNumber ?? '');
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
    
    // Initialize coordinates if editing existing address
    _latitude = address?.latitude;
    _longitude = address?.longitude;
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
            final user = ref.read(profileProvider).user;
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
      backgroundColor: ref.colors.background,
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Sửa địa chỉ' : 'Thêm địa chỉ mới',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ref.colors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ref.colors.primaryDark,
                ref.colors.primary,
              ],
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
                  onPressed: () => _showDeleteConfirmation(),
                ),
                SizedBox(width: ResponsiveSize.s),
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
        // Quick labels section
        _buildSectionTitle('Loại địa chỉ'),
        SizedBox(height: ResponsiveSize.s),
        _buildQuickLabelChips(),
        
        SizedBox(height: ResponsiveSize.l),
        
        // Label field
        _buildSectionTitle('Thông tin địa chỉ'),
        SizedBox(height: ResponsiveSize.s),
        _buildTextFormField(
          controller: _labelController,
          label: 'Nhãn địa chỉ',
          hintText: 'Ví dụ: Nhà riêng, Công ty...',
          icon: Icons.label_outline,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập nhãn địa chỉ';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // Recipient name field
        _buildTextFormField(
          controller: _recipientNameController,
          label: 'Tên người nhận',
          hintText: 'Nhập tên người nhận hàng',
          icon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập tên người nhận';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // Phone number field
        _buildTextFormField(
          controller: _phoneController,
          label: 'Số điện thoại',
          hintText: 'Nhập số điện thoại người nhận',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập số điện thoại';
            }
            if (value.trim().length < 10) {
              return 'Số điện thoại không hợp lệ';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.l),

        // Get current location button
        _buildGetLocationButton(),

        SizedBox(height: ResponsiveSize.l),

        // Address section
        _buildSectionTitle('Chi tiết địa chỉ'),
        SizedBox(height: ResponsiveSize.s),
        
        // Address line field
        _buildTextFormField(
          controller: _addressLineController,
          label: 'Địa chỉ chi tiết',
          hintText: 'Số nhà, tên đường...',
          icon: Icons.home_outlined,
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập địa chỉ chi tiết';
            }
            return null;
          },
        ),

        SizedBox(height: ResponsiveSize.m),

        // Ward & District in row
        Row(
          children: [
            Expanded(
              child: _buildTextFormField(
                controller: _wardController,
                label: 'Phường/Xã',
                hintText: 'Nhập phường/xã',
                icon: Icons.location_city_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bắt buộc';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: ResponsiveSize.m),
            Expanded(
              child: _buildTextFormField(
                controller: _districtController,
                label: 'Quận/Huyện',
                hintText: 'Nhập quận/huyện',
                icon: Icons.location_city_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bắt buộc';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),

        SizedBox(height: ResponsiveSize.m),

        // City & Postal code in row
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextFormField(
                controller: _cityController,
                label: 'Tỉnh/Thành phố',
                hintText: 'Nhập tỉnh/thành phố',
                icon: Icons.location_city_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bắt buộc';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: ResponsiveSize.m),
            Expanded(
              child: _buildTextFormField(
                controller: _postalCodeController,
                label: 'Mã bưu điện',
                hintText: 'Tùy chọn',
                icon: Icons.markunread_mailbox_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        SizedBox(height: ResponsiveSize.l),

        // Set as default - Card style
        Container(
          decoration: BoxDecoration(
            color: ref.colors.cardBackground,
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            border: Border.all(color: ref.colors.border),
          ),
          child: CheckboxListTile(
            title: const Text('Đặt làm địa chỉ mặc định'),
            subtitle: const Text('Địa chỉ này sẽ được chọn tự động khi đặt hàng'),
            value: _isDefault,
            onChanged: (value) {
              setState(() {
                _isDefault = value ?? false;
              });
            },
            activeColor: ref.colors.primary,
            controlAffinity: ListTileControlAffinity.leading,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            ),
          ),
        ),
        
        SizedBox(height: ResponsiveSize.l),
      ],
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveSize.fontL,
        fontWeight: FontWeight.bold,
        color: ref.colors.textPrimary,
      ),
    );
  }
  
  Widget _buildQuickLabelChips() {
    final labels = [
      {'label': 'Nhà riêng', 'icon': Icons.home_outlined},
      {'label': 'Công ty', 'icon': Icons.business_outlined},
      {'label': 'Trường học', 'icon': Icons.school_outlined},
      {'label': 'Khác', 'icon': Icons.location_on_outlined},
    ];
    
    return Wrap(
      spacing: ResponsiveSize.s,
      runSpacing: ResponsiveSize.s,
      children: labels.map((item) {
        final isSelected = _labelController.text == item['label'];
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item['icon'] as IconData,
                size: 16.w,
                color: isSelected ? Colors.white : ref.colors.primary,
              ),
              SizedBox(width: 4.w),
              Text(item['label'] as String),
            ],
          ),
          selected: isSelected,
          selectedColor: ref.colors.primary,
          backgroundColor: ref.colors.cardBackground,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : ref.colors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            side: BorderSide(
              color: isSelected ? ref.colors.primary : ref.colors.border,
            ),
          ),
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _labelController.text = item['label'] as String;
              });
            }
          },
        );
      }).toList(),
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
    final colors = ref.colors;
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: colors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: colors.textSecondary),
        hintStyle: TextStyle(color: colors.textDisabled),
        prefixIcon: Icon(icon, color: colors.primary),
        filled: true,
        fillColor: colors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          borderSide: BorderSide(color: colors.border),
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

  Widget _buildBottomActions() {
    final formState = ref.watch(addressFormProvider);
    final isLoading = formState.isLoading;
    final colors = ref.colors;

    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 10,
            color: colors.shadow,
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
                  icon: Icon(Icons.delete_outline, color: colors.error),
                  label: Text('Xóa', style: TextStyle(color: colors.error)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.error),
                    padding: EdgeInsets.symmetric(vertical: ResponsiveSize.m),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
                    ),
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
                    : const Icon(Icons.check),
                label: Text(
                  _isEditing ? 'Lưu thay đổi' : 'Thêm địa chỉ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: ResponsiveSize.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetLocationButton() {
    final locationState = ref.watch(currentLocationProvider);
    final colors = ref.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: colors.info.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                  ),
                  child: Icon(
                    Icons.gps_fixed,
                    color: colors.info,
                    size: 22.w,
                  ),
                ),
                SizedBox(width: ResponsiveSize.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lấy vị trí hiện tại',
                        style: TextStyle(
                          fontSize: ResponsiveSize.fontM,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Tự động điền địa chỉ từ GPS',
                        style: TextStyle(
                          fontSize: ResponsiveSize.fontS,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveSize.m),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: locationState.isLoading ? null : _getCurrentLocation,
                icon: locationState.isLoading
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(colors.info),
                        ),
                      )
                    : Icon(Icons.my_location, color: colors.info),
                label: Text(
                  locationState.isLoading ? 'Đang lấy vị trí...' : 'Lấy vị trí hiện tại',
                  style: TextStyle(color: colors.info, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.info),
                  padding: EdgeInsets.symmetric(vertical: ResponsiveSize.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
                  ),
                ),
              ),
            ),
            
            // Hiển thị tọa độ hiện tại (nếu có)
            if (_latitude != null && _longitude != null) ...[
              SizedBox(height: ResponsiveSize.m),
              Container(
                padding: EdgeInsets.all(ResponsiveSize.s),
                decoration: BoxDecoration(
                  color: colors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                  border: Border.all(color: colors.success.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: colors.success, size: 16.w),
                    SizedBox(width: ResponsiveSize.s),
                    Expanded(
                      child: Text(
                        'Tọa độ: ${_latitude!.toStringAsFixed(6)}, ${_longitude!.toStringAsFixed(6)}',
                        style: TextStyle(
                          fontSize: ResponsiveSize.fontS,
                          color: colors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Lấy vị trí hiện tại
      await ref.read(currentLocationProvider.notifier).getCurrentLocation();
      
      final locationState = ref.read(currentLocationProvider);
      
      locationState.when(
        data: (location) async {
          if (location != null) {
            // Lưu tọa độ GPS
            setState(() {
              _latitude = location.latitude;
              _longitude = location.longitude;
            });
            
            // Lấy địa chỉ từ tọa độ
            final address = await ref
                .read(currentLocationProvider.notifier)
                .getAddressFromLocation(location);
                
            if (address != null && mounted) {
              // Tự động fill vào form
              if (address.street?.isNotEmpty == true) {
                _addressLineController.text = address.street!;
              }
              if (address.subLocality?.isNotEmpty == true) {
                _wardController.text = address.subLocality!;
              }
              if (address.locality?.isNotEmpty == true) {
                _districtController.text = address.locality!;
              }
              if (address.administrativeArea?.isNotEmpty == true) {
                _cityController.text = address.administrativeArea!;
              }
              if (address.postalCode?.isNotEmpty == true) {
                _postalCodeController.text = address.postalCode!;
              }
              
              // Hiển thị thông báo thành công
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã lấy địa chỉ từ vị trí hiện tại\nTọa độ: ${_latitude?.toStringAsFixed(6)}, ${_longitude?.toStringAsFixed(6)}'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Không thể lấy vị trí: $error'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = ref.read(profileProvider).user;
    if (user?.id == null) {
      ToastUtils.showAddressAddError(
        context,
        message: 'Không tìm thấy thông tin người dùng',
      );
      return;
    }

    final requestDto = UserAddressRequestDto(
      label: _labelController.text.trim(),
      recipientName: _recipientNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      addressLine: _addressLineController.text.trim(),
      ward: _wardController.text.trim(),
      district: _districtController.text.trim(),
      city: _cityController.text.trim(),
      postalCode: _postalCodeController.text.trim().isEmpty
          ? null
          : _postalCodeController.text.trim(),
      latitude: _latitude,
      longitude: _longitude,
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

            try {
              ref
                  .read(userAddressListProvider.notifier)
                  .deleteAddress(widget.address!.id!);
              
              // Navigate back immediately - toast will be handled by listener
              if (mounted) {
                context.goBack();
              }
            } catch (e) {
              if (mounted) {
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
