import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/core/presentation/widgets/toast/toast_utils.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../domain/entities/user_address_entity.dart';
import '../providers/user_address_notifiers.dart';
import '../providers/user_address_state.dart';
import '../widgets/address_card.dart';

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
    final user = ref.read(profileProvider).user;
    if (user?.id != null) {
      ref.read(userAddressListProvider.notifier).loadAddresses(user!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(userAddressListProvider);
    final colors = context.colors;

    // Listen for error messages to show toast
    ref.listen<UserAddressListState>(userAddressListProvider, (previous, next) {
      if (next.errorMessage != null &&
          previous?.errorMessage != next.errorMessage) {
        ToastUtils.showAddressLoadError(context, message: next.errorMessage!);
      }

      // Listen for operation results
      if (next.lastOperation != null &&
          previous?.lastOperation != next.lastOperation) {
        final operation = next.lastOperation!;

        if (operation.isSuccess) {
          switch (operation.type) {
            case 'delete':
              ToastUtils.showAddressDeleteSuccess(context,
                  addressLabel: operation.addressLabel!);
              break;
            case 'setDefault':
              ToastUtils.showAddressSetDefaultSuccess(context,
                  addressLabel: operation.addressLabel!);
              break;
          }
        } else {
          switch (operation.type) {
            case 'delete':
              ToastUtils.showAddressDeleteError(context);
              break;
            case 'setDefault':
              ToastUtils.showAddressSetDefaultError(context);
              break;
          }
        }

        // Clear operation after showing toast
        ref.read(userAddressListProvider.notifier).clearOperation();
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          // Dark Nav AppBar
          SliverAppBar(
            expandedHeight: 120.h,
            pinned: true,
            backgroundColor: colors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Địa chỉ của tôi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveSize.fontXl,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors.primaryDark,
                      colors.primary,
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                onPressed: () => _navigateToAddAddress(),
              ),
              SizedBox(width: ResponsiveSize.s),
            ],
          ),

          // Content
          if (addressState.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (addressState.addresses.isEmpty)
            SliverFillRemaining(
              child: _buildEmptyState(),
            )
          else
            SliverPadding(
              padding: EdgeInsets.all(ResponsiveSize.m),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final address = addressState.addresses[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: ResponsiveSize.m),
                      child: AddressCard(
                        address: address,
                        onTap: () => _selectAddress(address),
                        onEdit: () => _navigateToEditAddress(address),
                        onDelete: () =>
                            _showDeleteConfirmation(context, address),
                        onSetDefault: () => _setDefaultAddress(address),
                      ),
                    );
                  },
                  childCount: addressState.addresses.length,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddAddress(),
        backgroundColor: colors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Thêm địa chỉ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_off_outlined,
                size: 60.w,
                color: colors.primary,
              ),
            ),
            SizedBox(height: ResponsiveSize.l),
            Text(
              'Chưa có địa chỉ nào',
              style: TextStyle(
                fontSize: ResponsiveSize.fontXl,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: ResponsiveSize.s),
            Text(
              'Thêm địa chỉ giao hàng để đặt món\nnhanh chóng hơn',
              style: TextStyle(
                fontSize: ResponsiveSize.fontM,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveSize.l),
            ElevatedButton.icon(
              onPressed: () => _navigateToAddAddress(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.l,
                  vertical: ResponsiveSize.m,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Thêm địa chỉ đầu tiên',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
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

  void _setDefaultAddress(UserAddressEntity address) {
    // Trigger the operation and let the notifier handle success/error state
    ref.read(userAddressListProvider.notifier).setDefaultAddress(address.id!);
  }

  void _showDeleteConfirmation(
      BuildContext context, UserAddressEntity address) {
    final colors = context.colors;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: colors.error),
            SizedBox(width: ResponsiveSize.s),
            const Text('Xác nhận xóa'),
          ],
        ),
        content: Text('Bạn có chắc muốn xóa địa chỉ "${address.label}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(userAddressListProvider.notifier)
                  .deleteAddress(address.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
