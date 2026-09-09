import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _previewAccent = Color(0xFFEE4D2D);

class CatalogRestaurantPreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const CatalogRestaurantPreviewHeader({
    super.key,
    required this.title,
    required this.cartItemCount,
    required this.onBack,
    required this.onCart,
  });

  final String title;
  final int cartItemCount;
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
      key: const Key('catalog_restaurant_back'),
      tooltip: 'Quay lại',
      onPressed: onBack,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back, color: _previewAccent, size: 22),
    ),
    title: Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
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
              key: const Key('catalog_restaurant_cart'),
              tooltip: 'Giỏ hàng',
              onPressed: onCart,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: PreviewUi.text(context),
                size: 22,
              ),
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 1,
                top: 4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _previewAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    cartItemCount > 99 ? '99+' : '$cartItemCount',
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

class CatalogRestaurantPreviewBody extends StatefulWidget {
  const CatalogRestaurantPreviewBody({
    super.key,
    required this.restaurant,
    required this.menuItems,
    required this.cartItemCount,
    required this.cartTotalAmount,
    required this.onIntent,
    required this.onItemOpen,
    this.deliveryAddressLabel,
    this.onManageAddress,
    this.onOpenVoucher,
  });

  final CatalogRestaurantDetailData restaurant;
  final List<CatalogMenuItemViewData> menuItems;
  final int cartItemCount;
  final double cartTotalAmount;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;
  final ValueChanged<CatalogMenuItemViewData> onItemOpen;
  final String? deliveryAddressLabel;
  final VoidCallback? onManageAddress;
  final VoidCallback? onOpenVoucher;

  @override
  State<CatalogRestaurantPreviewBody> createState() =>
      _CatalogRestaurantPreviewBodyState();
}

class _CatalogRestaurantPreviewBodyState
    extends State<CatalogRestaurantPreviewBody> {
  String _selectedTab = 'Phổ biến';

  @override
  Widget build(BuildContext context) {
    final showInfo = _selectedTab == 'Thông tin';
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            height: 180,
            child: AppContentImage(
              imageUrl: widget.restaurant.imageUrl,
              semanticLabel: widget.restaurant.name,
              height: 180,
              borderRadius: BorderRadius.zero,
              placeholderIcon: Icons.restaurant,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CatalogRestaurantPreviewSummary(restaurant: widget.restaurant),
        ),
        SliverToBoxAdapter(
          child: CatalogRestaurantPreviewDeliveryRow(
            restaurant: widget.restaurant,
            addressLabel: widget.deliveryAddressLabel,
            onPressed: widget.onManageAddress,
          ),
        ),
        SliverToBoxAdapter(
          child: CatalogRestaurantPreviewOfferRow(
            onPressed: widget.onOpenVoucher,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _PreviewTabsDelegate(
            selectedTab: _selectedTab,
            onSelected: (tab) => setState(() => _selectedTab = tab),
          ),
        ),
        if (showInfo)
          SliverToBoxAdapter(
            child: CatalogRestaurantPreviewInformation(
              restaurant: widget.restaurant,
            ),
          )
        else
          SliverToBoxAdapter(
            child: CatalogRestaurantPreviewMenu(
              title: _selectedTab == 'Phổ biến'
                  ? 'Món được yêu thích'
                  : 'Thực đơn',
              menuItems: widget.menuItems,
              onIntent: widget.onIntent,
              onItemOpen: widget.onItemOpen,
            ),
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: widget.cartItemCount > 0 ? 88 : 18),
        ),
      ],
    );
  }
}

class CatalogRestaurantPreviewSummary extends StatelessWidget {
  const CatalogRestaurantPreviewSummary({super.key, required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) {
    final rating = restaurant.rating ?? 4.8;
    final distance = restaurant.distanceKm ?? 1.2;
    final reviewCount = restaurant.reviewCount ?? 100;
    final reviewLabel = reviewCount >= 100 ? '100+' : '$reviewCount';
    final address = restaurant.address.trim().isEmpty
        ? 'Địa chỉ đang cập nhật'
        : restaurant.address;
    final openingHour = restaurant.openingHour ?? '08:00';
    final closingHour = restaurant.closingHour ?? '22:00';
    final isOpen = restaurant.isOpen ?? true;

    return ColoredBox(
      color: PreviewUi.surface(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: BoxDecoration(
                color: _previewAccent,
                borderRadius: BorderRadius.circular(1),
              ),
              child: const Text(
                'Quán yêu thích',
                style: TextStyle(color: Colors.white, fontSize: 9, height: 1.2),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              restaurant.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: PreviewUi.text(context),
                fontSize: 21,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: '★ ',
                    style: TextStyle(color: Color(0xFFFFB329)),
                  ),
                  TextSpan(text: '${rating.toStringAsFixed(1)}  '),
                  TextSpan(
                    text: '($reviewLabel)  |  ',
                    style: TextStyle(color: PreviewUi.muted(context)),
                  ),
                  TextSpan(text: '${distance.toStringAsFixed(1)} km'),
                ],
              ),
              style: TextStyle(fontSize: 12, color: PreviewUi.text(context)),
            ),
            const SizedBox(height: 7),
            Text(
              address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
            ),
            const SizedBox(height: 7),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: isOpen ? '● Đang mở cửa' : '● Đã đóng cửa',
                    style: TextStyle(
                      color: isOpen
                          ? const Color(0xFF229A69)
                          : PreviewUi.muted(context),
                    ),
                  ),
                  TextSpan(
                    text: '  ·  $openingHour – $closingHour',
                    style: TextStyle(color: PreviewUi.muted(context)),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class CatalogRestaurantPreviewDeliveryRow extends StatelessWidget {
  const CatalogRestaurantPreviewDeliveryRow({
    super.key,
    required this.restaurant,
    this.addressLabel,
    this.onPressed,
  });

  final CatalogRestaurantDetailData restaurant;
  final String? addressLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => _PreviewActionRow(
    backgroundColor: PreviewUi.surface(context),
    icon: Icons.delivery_dining,
    iconColor: _previewAccent,
    title: 'Giao trong 20–30 phút',
    subtitle: addressLabel?.trim().isNotEmpty == true
        ? addressLabel!
        : 'Nhà riêng',
    onPressed: onPressed,
  );
}

class CatalogRestaurantPreviewOfferRow extends StatelessWidget {
  const CatalogRestaurantPreviewOfferRow({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => _PreviewActionRow(
    backgroundColor: PreviewUi.accentSurface(context, alpha: .06),
    icon: Icons.confirmation_num_outlined,
    iconColor: _previewAccent,
    title: 'Freeship Xtra · Giảm phí giao 15.000đ',
    onPressed: onPressed,
    showSubtitle: false,
  );
}

class _PreviewActionRow extends StatelessWidget {
  const _PreviewActionRow({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onPressed,
    this.subtitle,
    this.showSubtitle = true,
  });

  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) => Material(
    color: backgroundColor,
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: showSubtitle
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: PreviewUi.text(context),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle ?? '',
                          style: TextStyle(
                            color: PreviewUi.muted(context),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(color: PreviewUi.accent, fontSize: 12),
                    ),
            ),
            if (onPressed != null)
              Icon(
                Icons.chevron_right,
                color: PreviewUi.muted(context),
                size: 20,
              ),
          ],
        ),
      ),
    ),
  );
}

class _PreviewTabsDelegate extends SliverPersistentHeaderDelegate {
  _PreviewTabsDelegate({required this.selectedTab, required this.onSelected});

  final String selectedTab;
  final ValueChanged<String> onSelected;

  @override
  double get minExtent => 49;

  @override
  double get maxExtent => 49;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => CatalogRestaurantPreviewTabs(
    selectedTab: selectedTab,
    onSelected: onSelected,
  );

  @override
  bool shouldRebuild(covariant _PreviewTabsDelegate oldDelegate) =>
      selectedTab != oldDelegate.selectedTab;
}

class CatalogRestaurantPreviewTabs extends StatelessWidget {
  const CatalogRestaurantPreviewTabs({
    super.key,
    required this.selectedTab,
    required this.onSelected,
  });

  final String selectedTab;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: PreviewUi.surface(context),
    child: Row(
      children: [
        for (final tab in const ['Phổ biến', 'Thực đơn', 'Thông tin'])
          Expanded(
            child: InkWell(
              onTap: () => onSelected(tab),
              child: Container(
                height: 49,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedTab == tab
                          ? _previewAccent
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: selectedTab == tab
                        ? _previewAccent
                        : PreviewUi.text(context),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class CatalogRestaurantPreviewInformation extends StatelessWidget {
  const CatalogRestaurantPreviewInformation({
    super.key,
    required this.restaurant,
  });

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: PreviewUi.surface(context),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin quán',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: PreviewUi.text(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            restaurant.address.trim().isEmpty
                ? 'Địa chỉ đang cập nhật'
                : restaurant.address,
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
          ),
          const SizedBox(height: 8),
          Text(
            'Giờ mở cửa: ${restaurant.openingHour ?? '08:00'}–${restaurant.closingHour ?? '22:00'}',
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
          ),
        ],
      ),
    ),
  );
}

class CatalogRestaurantPreviewMenu extends StatelessWidget {
  const CatalogRestaurantPreviewMenu({
    super.key,
    required this.title,
    required this.menuItems,
    required this.onIntent,
    required this.onItemOpen,
  });

  final String title;
  final List<CatalogMenuItemViewData> menuItems;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;
  final ValueChanged<CatalogMenuItemViewData> onItemOpen;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: PreviewUi.surface(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: PreviewUi.text(context),
            ),
          ),
          const SizedBox(height: 8),
          for (final item in menuItems)
            CatalogRestaurantPreviewMenuItem(
              item: item,
              onIntent: onIntent,
              onOpen: () => onItemOpen(item),
            ),
        ],
      ),
    ),
  );
}

class CatalogRestaurantPreviewMenuItem extends StatelessWidget {
  const CatalogRestaurantPreviewMenuItem({
    super.key,
    required this.item,
    required this.onIntent,
    required this.onOpen,
  });

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final description = item.description.trim().isEmpty
        ? 'Chuẩn vị, chế biến khi nhận đơn'
        : item.description;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onOpen,
            child: AppContentImage(
              imageUrl: item.imageUrl,
              semanticLabel: item.name,
              width: 95,
              height: 95,
              borderRadius: BorderRadius.circular(3),
              placeholderIcon: Icons.fastfood_outlined,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onOpen,
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: PreviewUi.muted(context),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Được yêu thích',
                    style: TextStyle(
                      fontSize: 10,
                      color: PreviewUi.muted(context),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        _previewMoney(item.displayedPrice),
                        style: const TextStyle(
                          color: _previewAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      if (item.quantity > 0)
                        _PreviewQuantityControl(item: item, onIntent: onIntent)
                      else
                        _PreviewAddButton(
                          onPressed: item.canAdd ? onOpen : null,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewAddButton extends StatelessWidget {
  const _PreviewAddButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 30,
    height: 30,
    child: IconButton(
      key: const Key('catalog_preview_menu_add'),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        backgroundColor: _previewAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      icon: const Icon(Icons.add, size: 21),
    ),
  );
}

class _PreviewQuantityControl extends StatelessWidget {
  const _PreviewQuantityControl({required this.item, required this.onIntent});

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 30,
        height: 30,
        child: IconButton(
          onPressed: () =>
              onIntent(CatalogRestaurantDetailDecrementRequested(item.id!)),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.remove, size: 17, color: _previewAccent),
        ),
      ),
      Text(
        '${item.quantity}',
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        width: 30,
        height: 30,
        child: IconButton(
          onPressed: item.canAdd
              ? () => onIntent(
                  CatalogRestaurantDetailIncrementRequested(item.id!),
                )
              : null,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add, size: 17, color: _previewAccent),
        ),
      ),
    ],
  );
}

class CatalogRestaurantPreviewCartButton extends StatelessWidget {
  const CatalogRestaurantPreviewCartButton({
    super.key,
    required this.itemCount,
    required this.totalAmount,
    required this.onPressed,
  });

  final int itemCount;
  final double totalAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Material(
    color: PreviewUi.surface(context),
    elevation: 3,
    child: SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      child: SizedBox(
        height: 44,
        child: Material(
          color: _previewAccent,
          borderRadius: BorderRadius.circular(3),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    '$itemCount món · ${_previewMoney(totalAmount)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Xem giỏ hàng →',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

String _previewMoney(num value) =>
    '${NumberFormat('#,###', 'vi_VN').format(value)}đ';
