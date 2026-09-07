import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/di/checkout_providers.dart';
import 'package:delivery_app/features/cart/di/checkout_voucher_provider.dart';

class VoucherWalletPage extends ConsumerStatefulWidget {
  const VoucherWalletPage({super.key});

  @override
  ConsumerState<VoucherWalletPage> createState() => _VoucherWalletPageState();
}

class _VoucherWalletPageState extends ConsumerState<VoucherWalletPage> {
  final TextEditingController _codeController = TextEditingController();
  bool _isRedeeming = false;
  String _selectedFilter = 'ALL';

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _redeemCode() async {
    final code = _codeController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    FocusScope.of(context).unfocus();
    setState(() => _isRedeeming = true);

    try {
      await ref.read(checkoutVoucherGatewayProvider).collect(code);
      if (!mounted) return;

      _codeController.clear();
      ref.invalidate(checkoutVoucherWalletProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã lưu mã "$code" vào ví voucher thành công!'),
          backgroundColor: const Color(0xFF00A38C),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mã voucher không hợp lệ, đã hết hạn hoặc đã được lưu.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isRedeeming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletAsync = ref.watch(checkoutVoucherWalletProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Ví Voucher & Ưu đãi',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2C3E50),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(checkoutVoucherWalletProvider);
          await ref.read(checkoutVoucherWalletProvider.future);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Code input section
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nhập mã ưu đãi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F3F5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _codeController,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9_-]'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Nhập mã (ví dụ: FREESHIP, FOOD20)',
                                hintStyle: TextStyle(
                                  color: Color(0xFF95A5A6),
                                  fontSize: 13,
                                ),
                                prefixIcon: Icon(
                                  Icons.confirmation_number_outlined,
                                  size: 20,
                                  color: Color(0xFF7F8C8D),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onSubmitted: (_) => _redeemCode(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 46,
                          child: ElevatedButton(
                            onPressed: _isRedeeming ? null : _redeemCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A38C),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                            ),
                            child: _isRedeeming
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Áp dụng',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Category filter chips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'Tất cả',
                        isSelected: _selectedFilter == 'ALL',
                        onTap: () => setState(() => _selectedFilter = 'ALL'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Freeship',
                        isSelected: _selectedFilter == 'FREESHIP',
                        onTap: () =>
                            setState(() => _selectedFilter = 'FREESHIP'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Giảm quán ăn',
                        isSelected: _selectedFilter == 'SHOP',
                        onTap: () => setState(() => _selectedFilter = 'SHOP'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Ưu đãi sàn',
                        isSelected: _selectedFilter == 'PLATFORM',
                        onTap: () =>
                            setState(() => _selectedFilter = 'PLATFORM'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Voucher items list
            walletAsync.when(
              data: (vouchers) {
                final filtered = vouchers.where((v) {
                  if (_selectedFilter == 'FREESHIP') {
                    return v.rewardType == 'FREESHIP' ||
                        v.layer == 'FREESHIP';
                  }
                  if (_selectedFilter == 'SHOP') {
                    return v.layer == 'SHOP_DISCOUNT' ||
                        v.fundingSource == 'SHOP';
                  }
                  if (_selectedFilter == 'PLATFORM') {
                    return v.layer == 'PLATFORM_DISCOUNT' ||
                        v.fundingSource == 'PLATFORM';
                  }
                  return true;
                }).toList();

                if (filtered.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00A38C).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.card_giftcard_rounded,
                                size: 42,
                                color: Color(0xFF00A38C),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Chưa có mã ưu đãi nào',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Nhập mã voucher phía trên hoặc kiểm tra lại các chương trình khuyến mãi hiện có.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF7F8C8D),
                              ),
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton(
                              onPressed: () => context.pushToRestaurants(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF00A38C),
                                side: const BorderSide(
                                  color: Color(0xFF00A38C),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Khám phá món ngon ngay'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final voucher = filtered[index];
                        return _VoucherCard(
                          voucher: voucher,
                          onUseNow: () => context.pushToRestaurants(),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF00A38C),
                  ),
                ),
              ),
              error: (error, _) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Không thể tải ví voucher',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () =>
                              ref.invalidate(checkoutVoucherWalletProvider),
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00A38C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00A38C)
                : const Color(0xFFE0E0E0),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00A38C).withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF555555),
          ),
        ),
      ),
    );
  }
}

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({
    required this.voucher,
    required this.onUseNow,
  });

  final CheckoutVoucher voucher;
  final VoidCallback onUseNow;

  @override
  Widget build(BuildContext context) {
    final isFreeship =
        voucher.rewardType == 'FREESHIP' || voucher.layer == 'FREESHIP';
    final primaryColor =
        isFreeship ? const Color(0xFF00A38C) : const Color(0xFFE67E22);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left badge column
            Container(
              width: 88,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(14),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFreeship
                        ? Icons.local_shipping_outlined
                        : Icons.discount_outlined,
                    color: primaryColor,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    voucher.displayBenefit,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Center details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            voucher.code,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: voucher.code),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Đã sao chép mã ${voucher.code}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.copy_rounded,
                            size: 14,
                            color: Color(0xFF95A5A6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      voucher.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      voucher.minOrderValue != null && voucher.minOrderValue! > 0
                          ? 'Đơn tối thiểu ${(voucher.minOrderValue!).toStringAsFixed(0)}đ'
                          : 'Áp dụng cho mọi đơn',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF7F8C8D),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Right Action
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: SizedBox(
                  height: 32,
                  child: OutlinedButton(
                    onPressed: onUseNow,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(color: primaryColor),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Dùng ngay',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
