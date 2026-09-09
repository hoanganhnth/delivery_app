import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
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
    if (_isRedeeming) return;
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Mã voucher không hợp lệ, đã hết hạn hoặc đã được lưu.',
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isRedeeming = false);
    }
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletAsync = ref.watch(checkoutVoucherWalletProvider);

    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: 'Ví Voucher & Ưu đãi',
        onBack: _goBack,
        onCart: () => context.pushCart(),
        // Keep the existing 52px contract while using preview styling.
        toolbarHeight: 52,
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
                color: PreviewUi.surface(context),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nhập mã ưu đãi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: PreviewUi.controlRadius,
                            ),
                            child: TextField(
                              controller: _codeController,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9_-]'),
                                ),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Nhập mã (ví dụ: FREESHIP, FOOD20)',
                                hintStyle: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontSize: 13,
                                ),
                                prefixIcon: Icon(
                                  Icons.confirmation_number_outlined,
                                  size: 20,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
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
                        SizedBox(width: 10),
                        SizedBox(
                          height: 46,
                          child: ElevatedButton(
                            onPressed: _isRedeeming ? null : _redeemCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                            ),
                            child: _isRedeeming
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                    ),
                                  )
                                : Text(
                                    'Lưu mã',
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
                      SizedBox(width: 8),
                      _FilterChip(
                        label: 'Freeship',
                        isSelected: _selectedFilter == 'FREESHIP',
                        onTap: () =>
                            setState(() => _selectedFilter = 'FREESHIP'),
                      ),
                      SizedBox(width: 8),
                      _FilterChip(
                        label: 'Giảm quán ăn',
                        isSelected: _selectedFilter == 'SHOP',
                        onTap: () => setState(() => _selectedFilter = 'SHOP'),
                      ),
                      SizedBox(width: 8),
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
                    return v.rewardType == 'FREESHIP' || v.layer == 'FREESHIP';
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
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.card_giftcard_rounded,
                                size: 42,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Chưa có mã ưu đãi nào',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Nhập mã voucher phía trên hoặc kiểm tra lại các chương trình khuyến mãi hiện có.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 20),
                            OutlinedButton(
                              onPressed: () => context.pushToRestaurants(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text('Khám phá món ngon ngay'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final voucher = filtered[index];
                      return _VoucherCard(
                        voucher: voucher,
                        onUseNow: () {
                          if (voucher.unavailableReasonAt(DateTime.now()) !=
                              null) {
                            setState(() {});
                            return;
                          }
                          if (voucher.scopeType == 'SHOP') {
                            context.pushToRestaurantDetails(
                              voucher.scopeRefId.toString(),
                            );
                          } else {
                            context.pushToRestaurants();
                          }
                        },
                      );
                    }, childCount: filtered.length),
                  ),
                );
              },
              loading: () => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
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
                        Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Colors.redAccent,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Không thể tải ví voucher',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () =>
                              ref.invalidate(checkoutVoucherWalletProvider),
                          child: Text('Thử lại'),
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
    return Semantics(
      selected: isSelected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            borderRadius: PreviewUi.controlRadius,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0xFFE0E0E0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({required this.voucher, required this.onUseNow});

  final CheckoutVoucher voucher;
  final VoidCallback onUseNow;

  @override
  Widget build(BuildContext context) {
    final isFreeship =
        voucher.rewardType == 'FREESHIP' || voucher.layer == 'FREESHIP';
    final unavailableReason = voucher.unavailableReasonAt(DateTime.now());
    final primaryColor = isFreeship
        ? Theme.of(context).colorScheme.primary
        : const Color(0xFFE67E22);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: PreviewUi.surface(context),
        borderRadius: PreviewUi.controlRadius,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
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
                  left: Radius.circular(3),
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
                  SizedBox(height: 6),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: PreviewUi.controlRadius,
                          ),
                          child: Text(
                            voucher.code,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
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
                          child: Icon(
                            Icons.copy_rounded,
                            size: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      voucher.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      voucher.minOrderValue != null &&
                              voucher.minOrderValue! > 0
                          ? 'Đơn tối thiểu ${(voucher.minOrderValue!).toStringAsFixed(0)}đ'
                          : 'Không yêu cầu đơn tối thiểu',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      voucher.scopeType == 'SHOP'
                          ? 'Chỉ áp dụng tại quán #${voucher.scopeRefId}'
                          : 'Áp dụng tại tất cả quán',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (voucher.maxDiscountValue != null)
                      Text(
                        'Giảm tối đa ${voucher.maxDiscountValue!.toStringAsFixed(0)}đ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (voucher.endTime != null)
                      Text(
                        'Hạn dùng: ${DateFormat('dd/MM/yyyy HH:mm').format(voucher.endTime!.toLocal())}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (unavailableReason != null)
                      Text(
                        unavailableReason,
                        style: Theme.of(context).textTheme.bodySmall,
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
                  height: 48,
                  child: OutlinedButton(
                    onPressed: unavailableReason == null ? onUseNow : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(color: primaryColor),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                    child: Text(
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
