import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:delivery_app/core/presentation/widgets/toast/toast_utils.dart';
import '../../domain/entities/user_address_entity.dart';
import '../providers/user_address_providers.dart';
import '../widgets/address_item_widget.dart';

class AddressListScreen extends ConsumerStatefulWidget {
  const AddressListScreen({super.key});

  @override
  ConsumerState<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends ConsumerState<AddressListScreen> 
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Load addresses when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAddresses();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadAddresses();
    }
  }

  void _loadAddresses() {
    final user = ref.read(profileStateProvider).user;
    if (user?.id != null) {
      ref.read(userAddressListProvider.notifier).loadAddresses(user!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(userAddressListProvider);
    
    // Listen for error messages to show toast
    ref.listen(userAddressListProvider, (previous, next) {
      if (next.errorMessage != null && previous?.errorMessage != next.errorMessage) {
        ToastUtils.showAddressLoadError(context, message: next.errorMessage);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa chỉ của tôi'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAddAddress(),
          ),
        ],
      ),
      body: addressState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : addressState.addresses.isEmpty
              ? _buildEmptyState()
              : _buildAddressList(addressState.addresses),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddAddress(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 80.w,
            color: Colors.grey,
          ),
          SizedBox(height: ResponsiveSize.m),
          Text(
            'Chưa có địa chỉ nào',
            style: TextStyle(
              fontSize: ResponsiveSize.fontL,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: ResponsiveSize.s),
          Text(
            'Thêm địa chỉ để dễ dàng đặt hàng',
            style: TextStyle(
              fontSize: ResponsiveSize.fontM,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ResponsiveSize.l),
          ElevatedButton.icon(
            onPressed: () => _navigateToAddAddress(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.l,
                vertical: ResponsiveSize.m,
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Thêm địa chỉ mới'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList(List<UserAddressEntity> addresses) {
    return ListView.separated(
      padding: EdgeInsets.all(ResponsiveSize.m),
      itemCount: addresses.length,
      separatorBuilder: (context, index) => SizedBox(height: ResponsiveSize.s),
      itemBuilder: (context, index) {
        final address = addresses[index];
        return AddressItemWidget(
          address: address,
          onTap: () => _selectAddress(address),
          onEdit: () => _navigateToEditAddress(address),
          onDelete: () => _showDeleteConfirmation(context, address),
          onSetDefault: () => _setDefaultAddress(address),
        );
      },
    );
  }

  void _navigateToAddAddress() {
    context.pushAddAddress();
  }

  void _navigateToEditAddress(UserAddressEntity address) {
    context.pushEditAddress(address);
  }

  void _selectAddress(UserAddressEntity address) {
    // Set selected address và quay về màn hình trước
    ref.read(userAddressListProvider.notifier).selectAddress(address);
    Navigator.pop(context);
  }

  void _setDefaultAddress(UserAddressEntity address) async {
    final success = await ref.read(userAddressListProvider.notifier).setDefaultAddress(address.id!);
    
    if (mounted) {
      if (success) {
        ToastUtils.showAddressSetDefaultSuccess(context, addressLabel: address.label);
      } else {
        ToastUtils.showAddressSetDefaultError(context);
      }
    }
  }

  void _showDeleteConfirmation(BuildContext context, UserAddressEntity address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa địa chỉ "${address.label}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref.read(userAddressListProvider.notifier).deleteAddress(address.id!);
              
              if (mounted) {
                if (success) {
                  ToastUtils.showAddressDeleteSuccess(context, addressLabel: address.label);
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
