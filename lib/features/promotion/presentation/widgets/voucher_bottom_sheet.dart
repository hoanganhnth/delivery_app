import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/dtos/calculate_response_dto.dart';
import '../providers/checkout_calculation_notifier.dart';
import '../providers/selected_vouchers_notifier.dart';

class VoucherBottomSheet extends ConsumerWidget {
  const VoucherBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculateState = ref.watch(checkoutCalculationProvider);
    final selectedVouchers = ref.watch(selectedVouchersProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: calculateState.when(
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.amber)),
              error: (e, _) => Center(child: Text('Lỗi tải mã giảm giá: $e')),
              data: (data) {
                if (data == null) return const Center(child: Text('Đang xử lý...'));
                return _buildVoucherTabs(context, data, selectedVouchers, ref);
              },
            ),
          ),
          _buildBottomAction(context, selectedVouchers),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chọn Mã Giảm Giá',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherTabs(BuildContext context, CalculateResponseDto data, List<int> selectedVouchers, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.amber.shade900,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.amber.shade700,
            tabs: [
              Tab(text: 'Khả dụng (${data.availableVouchers.length})'),
              Tab(text: 'Không khả dụng (${data.unavailableVouchers.length})'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildAvailableList(data.availableVouchers, selectedVouchers, ref),
                _buildUnavailableList(data.unavailableVouchers),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableList(List<VoucherInfoDto> vouchers, List<int> selectedVouchers, WidgetRef ref) {
    if (vouchers.isEmpty) {
      return const Center(child: Text('Chưa có mã giảm giá khả dụng.'));
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        final isSelected = selectedVouchers.contains(voucher.id);
        
        return Card(
          elevation: 0,
          margin: EdgeInsets.only(bottom: 12.w),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: isSelected ? Colors.amber.shade600 : Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: InkWell(
            onTap: () {
              ref.read(selectedVouchersProvider.notifier).toggleVoucher(voucher.id);
            },
            borderRadius: BorderRadius.circular(12.w),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.local_offer, color: Colors.amber.shade700),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          voucher.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          'Mã: ${voucher.code}',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                  Checkbox(
                    value: isSelected,
                    onChanged: (_) {
                      ref.read(selectedVouchersProvider.notifier).toggleVoucher(voucher.id);
                    },
                    activeColor: Colors.amber.shade700,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUnavailableList(List<UnavailableVoucherInfoDto> vouchers) {
    if (vouchers.isEmpty) {
      return const Center(child: Text('Không có mã không khả dụng.'));
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        return Card(
          elevation: 0,
          margin: EdgeInsets.only(bottom: 12.w),
          color: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.local_offer, color: Colors.grey.shade400),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.grey.shade600),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        voucher.reason,
                        style: TextStyle(color: Colors.red.shade400, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomAction(BuildContext context, List<int> selectedVouchers) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Optional: call a trigger to recalculate if needed
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            minimumSize: Size(double.infinity, 48.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.w),
            ),
          ),
          child: Text(
            'Áp dụng ${selectedVouchers.isNotEmpty ? '(${selectedVouchers.length})' : ''}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
