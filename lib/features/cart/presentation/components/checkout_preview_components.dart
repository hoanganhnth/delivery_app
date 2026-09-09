import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/presentation/components/checkout_components.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

const _checkoutPreviewAccent = Color(0xFFEE4D2D);
const _checkoutPreviewMuted = Color(0xFF777777);

class CheckoutPreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const CheckoutPreviewHeader({
    super.key,
    required this.itemCount,
    required this.onBack,
    required this.onCart,
  });

  final int itemCount;
  final VoidCallback onBack;
  final VoidCallback onCart;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 50,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: PreviewUi.surface(context),
    leadingWidth: 44,
    leading: IconButton(
      key: const Key('checkout_back'),
      tooltip: 'Quay lại',
      onPressed: onBack,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back, color: _checkoutPreviewAccent),
    ),
    title: Text(
      'Xác nhận đơn hàng',
      style: TextStyle(
        color: PreviewUi.text(context),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      SizedBox(
        width: 44,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            IconButton(
              key: const Key('checkout_cart_action'),
              tooltip: 'Giỏ hàng',
              onPressed: onCart,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            ),
            if (itemCount > 0)
              Positioned(
                right: 1,
                top: 4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _checkoutPreviewAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    itemCount > 99 ? '99+' : '$itemCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class CheckoutPreviewBody extends StatelessWidget {
  const CheckoutPreviewBody({
    super.key,
    required this.state,
    required this.notesController,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final TextEditingController notesController;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isCartLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasCartError) {
      return _CheckoutPreviewMessage(
        title: 'Chưa tải được thông tin thanh toán',
        actionLabel: 'Thử lại',
        onAction: () => onIntent(const CheckoutPreviewRetryRequested()),
      );
    }
    if (state.isEmpty) {
      return _CheckoutPreviewMessage(
        title: 'Chưa có món trong giỏ',
        message: 'Chọn món để bắt đầu đặt hàng.',
        actionLabel: 'Khám phá món ngon',
        onAction: () => onIntent(const CheckoutBackRequested()),
      );
    }

    return Column(
      children: [
        if (state.isPreviewLoading)
          const _CheckoutPreviewPriceHint('Đang tính phí giao hàng…'),
        if (state.hasPreviewError)
          _CheckoutPreviewPriceHint(
            'Không thể lấy giá từ server. Nhấn để thử lại.',
            onTap: () => onIntent(const CheckoutPreviewRetryRequested()),
          ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              CheckoutPreviewAddress(
                address: state.selectedAddress,
                onTap: () =>
                    onIntent(const CheckoutAddressSelectionRequested()),
              ),
              CheckoutPreviewRestaurantBlock(
                state: state,
                notesController: notesController,
                onIntent: onIntent,
              ),
              CheckoutPreviewVoucherRow(state: state, onIntent: onIntent),
              CheckoutPreviewPaymentSummary(state: state),
              const CheckoutPreviewPaymentMethod(),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 22),
                child: Text(
                  'Kiểm tra địa chỉ và món ăn trước khi đặt đơn.',
                  style: TextStyle(fontSize: 11, color: _checkoutPreviewMuted),
                ),
              ),
              const SizedBox(height: 82),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckoutPreviewAddress extends StatelessWidget {
  const CheckoutPreviewAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final CheckoutAddressViewData? address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final value = address;
    return Material(
      color: PreviewUi.surface(context),
      child: InkWell(
        key: const Key('checkout_address_selector'),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 18, 12, 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: _checkoutPreviewAccent, width: 3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: _checkoutPreviewAccent,
                size: 21,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: value == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thêm địa chỉ giao hàng',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Chọn địa chỉ để tính phí giao hàng.',
                            style: TextStyle(
                              fontSize: 12,
                              color: PreviewUi.muted(context),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.label,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            value.fullAddress,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${value.recipientName} · ${value.phoneNumber}',
                            style: TextStyle(
                              fontSize: 11,
                              color: PreviewUi.muted(context),
                            ),
                          ),
                        ],
                      ),
              ),
              const Icon(
                Icons.chevron_right,
                color: _checkoutPreviewAccent,
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutPreviewRestaurantBlock extends StatelessWidget {
  const CheckoutPreviewRestaurantBlock({
    super.key,
    required this.state,
    required this.notesController,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final TextEditingController notesController;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) => _CheckoutPreviewSection(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.restaurantName ?? 'Nhà hàng',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'Giao hàng · 20–30 phút',
          style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
        ),
        const SizedBox(height: 7),
        for (final line in state.lines) ...[
          _CheckoutPreviewOrderLine(line: line),
          Divider(height: 1, color: PreviewUi.divider(context)),
        ],
        const SizedBox(height: 14),
        TextField(
          key: const Key('checkout_notes'),
          controller: notesController,
          maxLines: 1,
          maxLength: 500,
          textInputAction: TextInputAction.done,
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            labelText: 'Ghi chú cho quán',
            hintText: 'Ví dụ: ít cay, không hành',
            counterText: '',
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEEEEEE)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEEEEEE)),
            ),
          ),
          onChanged: (notes) => onIntent(CheckoutNotesChanged(notes)),
        ),
      ],
    ),
  );
}

class _CheckoutPreviewOrderLine extends StatelessWidget {
  const _CheckoutPreviewOrderLine({required this.line});

  final CheckoutLineViewData line;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            '${line.quantity}×',
            style: const TextStyle(fontSize: 11),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(child: Text(line.name, style: const TextStyle(fontSize: 12))),
        const SizedBox(width: 8),
        Text(
          _checkoutMoney(line.lineTotal),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class CheckoutPreviewVoucherRow extends StatelessWidget {
  const CheckoutPreviewVoucherRow({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) => Material(
    color: PreviewUi.surface(context),
    child: InkWell(
      key: const Key('checkout_voucher_row'),
      onTap: state.isVoucherAvailable
          ? () => _showVoucherPicker(context)
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Row(
          children: [
            const Icon(
              Icons.confirmation_number,
              color: _checkoutPreviewAccent,
            ),
            const SizedBox(width: 8),
            const Text(
              'ShopeeFood Voucher',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              _voucherLabel,
              style: const TextStyle(
                fontSize: 12,
                color: _checkoutPreviewAccent,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.chevron_right,
              color: _checkoutPreviewAccent,
              size: 18,
            ),
          ],
        ),
      ),
    ),
  );

  String get _voucherLabel {
    if (!state.isVoucherAvailable) return 'Chọn mã';
    if (state.selectedVoucherIds.isNotEmpty ||
        state.selectedVoucherId != null) {
      return 'Đã chọn';
    }
    return 'Chọn mã';
  }

  Future<void> _showVoucherPicker(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: PreviewUi.surface(context),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: CheckoutVoucherSelector(state: state, onIntent: onIntent),
        ),
      ),
    );
  }
}

class CheckoutPreviewPaymentSummary extends StatelessWidget {
  const CheckoutPreviewPaymentSummary({super.key, required this.state});

  final CheckoutViewState state;

  @override
  Widget build(BuildContext context) {
    final price = state.price;
    return _CheckoutPreviewSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chi tiết thanh toán',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 9),
          _CheckoutPreviewPriceLine(
            label: 'Tổng tiền món (${state.itemCount} món)',
            value: price?.subtotal,
          ),
          _CheckoutPreviewPriceLine(
            label: 'Phí giao hàng',
            value: price?.shippingFee,
          ),
          if (price != null && price.discountAmount > 0)
            _CheckoutPreviewPriceLine(
              label: 'Ưu đãi phí giao hàng',
              value: -price.discountAmount,
              isDiscount: true,
            ),
          const Divider(height: 25, color: Color(0xFFEEEEEE)),
          _CheckoutPreviewPriceLine(
            label: 'Tổng thanh toán',
            value: price?.total,
            emphasized: true,
          ),
        ],
      ),
    );
  }
}

class _CheckoutPreviewPriceLine extends StatelessWidget {
  const _CheckoutPreviewPriceLine({
    required this.label,
    required this.value,
    this.isDiscount = false,
    this.emphasized = false,
  });

  final String label;
  final double? value;
  final bool isDiscount;
  final bool emphasized;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: emphasized ? 15 : 13,
              fontWeight: emphasized ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value == null
              ? '…'
              : '${isDiscount ? '−' : ''}${_checkoutMoney(value!.abs())}',
          style: TextStyle(
            color: isDiscount || emphasized
                ? _checkoutPreviewAccent
                : PreviewUi.text(context),
            fontSize: emphasized ? 17 : 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class CheckoutPreviewPaymentMethod extends StatelessWidget {
  const CheckoutPreviewPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) => _CheckoutPreviewSection(
    child: Row(
      children: [
        const Icon(Icons.payments, color: _checkoutPreviewAccent),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Thanh toán khi nhận hàng',
            style: TextStyle(fontSize: 13),
          ),
        ),
        const Icon(Icons.check_circle, color: Color(0xFF2A9D70), size: 21),
      ],
    ),
  );
}

class CheckoutPreviewStickyAction extends StatelessWidget {
  const CheckoutPreviewStickyAction({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) => Material(
    color: PreviewUi.surface(context),
    elevation: 3,
    child: SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tổng thanh toán',
                  style: TextStyle(
                    fontSize: 10,
                    color: PreviewUi.muted(context),
                  ),
                ),
                Text(
                  state.price == null
                      ? '…'
                      : _checkoutMoney(state.price!.total),
                  style: const TextStyle(
                    color: _checkoutPreviewAccent,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 130,
            height: 44,
            child: FilledButton(
              key: const Key('checkout_place_order'),
              onPressed: state.canPlaceOrder
                  ? () => onIntent(const CheckoutPlaceOrderRequested())
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: _checkoutPreviewAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: state.isPlacingOrder
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Đặt đơn'),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CheckoutPreviewSection extends StatelessWidget {
  const _CheckoutPreviewSection({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(16),
    color: PreviewUi.surface(context),
    child: child,
  );
}

class _CheckoutPreviewPriceHint extends StatelessWidget {
  const _CheckoutPreviewPriceHint(this.message, {this.onTap});

  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: PreviewUi.accentSurface(context, alpha: .06),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              size: 16,
              color: _checkoutPreviewAccent,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 11, color: PreviewUi.text(context)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _CheckoutPreviewMessage extends StatelessWidget {
  const _CheckoutPreviewMessage({
    required this.title,
    required this.actionLabel,
    required this.onAction,
    this.message,
  });

  final String title;
  final String? message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 54,
            color: Color(0xFFDCCBC2),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
            ),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: 220,
            height: 44,
            child: FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: _checkoutPreviewAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Text(actionLabel),
            ),
          ),
        ],
      ),
    ),
  );
}

String _checkoutMoney(num value) => '${value.toStringAsFixed(0)}đ';
