import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'catalog_restaurant_list.dart';
import 'home_mock_data.dart';
import 'home_style.dart';

class HomeRestaurantsSection extends StatefulWidget {
  const HomeRestaurantsSection({
    super.key,
    required this.state,
    required this.onIntent,
    this.category = 'Tất cả',
    this.onClearCategory,
  });
  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;
  final String category;
  final VoidCallback? onClearCategory;
  @override
  State<HomeRestaurantsSection> createState() => _HomeRestaurantsSectionState();
}

class _HomeRestaurantsSectionState extends State<HomeRestaurantsSection> {
  String _sort = 'Đề xuất';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mock = widget.state.restaurants.isEmpty && !widget.state.isLoading;
    final source = mock ? homeMockRestaurants : widget.state.restaurants;
    final rows =
        source
            .where(
              (r) =>
                  widget.category == 'Tất cả' || r.category == widget.category,
            )
            .toList();
    if (_sort == 'Đánh giá') {
      rows.sort((a, b) => (b.rating ?? -1).compareTo(a.rating ?? -1));
    } else if (_sort == 'Gần tôi') {
      rows.sort(
        (a, b) => (a.distanceKm ?? double.infinity).compareTo(
          b.distanceKm ?? double.infinity,
        ),
      );
    }
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          outlineVariant:
              theme.brightness == Brightness.dark
                  ? const Color(0xFF393939)
                  : const Color(0xFFEEEEEE),
        ),
      ),
      child: ColoredBox(
        color: HomeStyle.surface(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  Localizations.localeOf(context).languageCode == 'vi'
                      ? 'Quán ngon dành cho bạn'
                      : S.of(context).pilotHomeFeatured,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final label in ['Đề xuất', 'Gần tôi', 'Đánh giá'])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: OutlinedButton(
                          onPressed: () => setState(() => _sort = label),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 32),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor:
                                _sort == label
                                    ? HomeStyle.accent(
                                      context,
                                    ).withValues(alpha: .04)
                                    : null,
                            foregroundColor:
                                _sort == label
                                    ? HomeStyle.accent(context)
                                    : HomeStyle.muted(context),
                            side: BorderSide(
                              color:
                                  _sort == label
                                      ? HomeStyle.accent(context)
                                      : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(label, style: const TextStyle(fontSize: 11)),
                              if (label == 'Đề xuất') ...[
                                const SizedBox(width: 5),
                                const Icon(Icons.tune, size: 15),
                              ],
                            ],
                          ),
                        ),
                      ),
                    if (widget.category != 'Tất cả')
                      TextButton(
                        onPressed: widget.onClearCategory,
                        child: Text('${widget.category} ×'),
                      ),
                  ],
                ),
              ),
              if (widget.state.hasError)
                TextButton(
                  onPressed:
                      () => widget.onIntent(const CatalogHomeLoadRequested()),
                  child: const Text('Thử lại'),
                ),
              CatalogRestaurantList(
                state: widget.state.copyWith(
                  restaurants: rows,
                  clearError: true,
                ),
                onIntent: widget.onIntent,
              ),
              if (mock)
                Text(
                  'Danh sách mẫu — chưa kết nối dữ liệu quán',
                  style: TextStyle(
                    fontSize: 10,
                    color: HomeStyle.muted(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
