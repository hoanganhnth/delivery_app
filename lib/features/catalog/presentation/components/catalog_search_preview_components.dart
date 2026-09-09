import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_search_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_search_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_search_result_tiles.dart';
import 'package:flutter/material.dart';

import 'home/home_style.dart';

class CatalogSearchPreviewHeader extends StatelessWidget {
  const CatalogSearchPreviewHeader({
    super.key,
    required this.controller,
    required this.deliveryAddress,
    required this.onChanged,
    required this.onSubmitted,
    this.onBack,
    this.onManageAddress,
    this.onHome,
  });

  final TextEditingController controller;
  final String? deliveryAddress;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback? onBack;
  final VoidCallback? onManageAddress;
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    final address = deliveryAddress?.trim();
    final muted = HomeStyle.muted(context);
    final accent = HomeStyle.accent(context);
    return ColoredBox(
      color: HomeStyle.surface(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  _CompactIconButton(
                    tooltip: 'Quay lại',
                    icon: Icons.arrow_back,
                    color: accent,
                    onPressed: onBack,
                  ),
                  const SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Shopee',
                      style: TextStyle(
                        color: accent,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                      ),
                      children: [
                        TextSpan(
                          text: 'Food',
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDEDEDE)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _CompactIconButton(
                            tooltip: 'Quản lý địa chỉ',
                            icon: Icons.more_horiz,
                            size: 18,
                            onPressed: onManageAddress,
                          ),
                          const SizedBox(
                            height: 16,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                          _CompactIconButton(
                            tooltip: 'Về trang chủ',
                            icon: Icons.close,
                            size: 18,
                            onPressed: onHome,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              button: onManageAddress != null,
              label:
                  address == null || address.isEmpty
                      ? 'Chọn địa chỉ giao hàng'
                      : 'Giao đến: $address',
              child: InkWell(
                onTap: onManageAddress,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 36),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: accent, size: 18),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Giao đến: ',
                            children: [
                              TextSpan(
                                text:
                                    address == null || address.isEmpty
                                        ? 'Chọn địa chỉ giao hàng'
                                        : address,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: muted, size: 18),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: HomeStyle.canvas(context),
              borderRadius: HomeStyle.controlRadius,
              child: SizedBox(
                height: 38,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Icon(Icons.search, color: muted, size: 20),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        key: const Key('catalog_search_input'),
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        onChanged: onChanged,
                        onSubmitted: onSubmitted,
                        decoration: const InputDecoration(
                          hintText: 'Tìm món ngon, quán yêu thích…',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 7),
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    TextButton(
                      key: const Key('catalog_search_submit'),
                      onPressed: () => onSubmitted(controller.text),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 38),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        foregroundColor: accent,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Tìm', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactIconButton extends StatelessWidget {
  const _CompactIconButton({
    required this.tooltip,
    required this.icon,
    this.color,
    this.size = 19,
    this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final Color? color;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 36,
    height: 44,
    child: IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 44),
      icon: Icon(icon, color: color, size: size),
    ),
  );
}

class CatalogSearchPreviewResults extends StatelessWidget {
  const CatalogSearchPreviewResults({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogSearchViewState state;
  final ValueChanged<CatalogSearchIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isSearching && state.restaurants.isEmpty) {
      return ColoredBox(
        color: HomeStyle.surface(context),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    final restaurants = [...state.restaurants];
    switch (state.sort) {
      case CatalogSearchSort.recommended:
        break;
      case CatalogSearchSort.nearby:
        restaurants.sort(
          (left, right) => (left.distanceKm ?? double.infinity).compareTo(
            right.distanceKm ?? double.infinity,
          ),
        );
      case CatalogSearchSort.rating:
        restaurants.sort(
          (left, right) => (right.rating ?? -1).compareTo(left.rating ?? -1),
        );
    }
    return ColoredBox(
      color: HomeStyle.surface(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                'Kết quả tìm kiếm',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterButton(
                    label: 'Đề xuất',
                    selected: state.sort == CatalogSearchSort.recommended,
                    leading: Icons.tune,
                    onPressed:
                        () => onIntent(
                          const CatalogSearchSortSelected(
                            CatalogSearchSort.recommended,
                          ),
                        ),
                  ),
                  _FilterButton(
                    label: 'Gần tôi',
                    selected: state.sort == CatalogSearchSort.nearby,
                    onPressed:
                        () => onIntent(
                          const CatalogSearchSortSelected(
                            CatalogSearchSort.nearby,
                          ),
                        ),
                  ),
                  _FilterButton(
                    label: 'Đánh giá',
                    selected: state.sort == CatalogSearchSort.rating,
                    onPressed:
                        () => onIntent(
                          const CatalogSearchSortSelected(
                            CatalogSearchSort.rating,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            if (state.hasRestaurantError && restaurants.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppStateFeedback.error(
                  title: 'Không thể tải danh sách nhà hàng',
                  message: 'Vui lòng kiểm tra kết nối mạng và thử lại.',
                  actionLabel: 'Thử lại',
                  onAction: () => onIntent(const CatalogSearchLoadRequested()),
                ),
              )
            else if (restaurants.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppStateFeedback.empty(
                  title: 'Không tìm thấy nhà hàng',
                  message: 'Hãy thử với từ khóa khác.',
                  icon: Icons.storefront_outlined,
                ),
              )
            else
              for (final restaurant in restaurants)
                CatalogRestaurantSearchResultTile(
                  item: restaurant,
                  onTap:
                      () => onIntent(
                        CatalogSearchRestaurantSelected(restaurant.id),
                      ),
                ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.label,
    required this.selected,
    required this.onPressed,
    this.leading,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final IconData? leading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 32),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor:
            selected ? HomeStyle.accent(context).withValues(alpha: .04) : null,
        foregroundColor:
            selected ? HomeStyle.accent(context) : HomeStyle.muted(context),
        side: BorderSide(
          color: selected ? HomeStyle.accent(context) : const Color(0xFFDDDDDD),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11)),
          if (leading != null) ...[
            const SizedBox(width: 5),
            Icon(leading, size: 15),
          ],
        ],
      ),
    ),
  );
}
