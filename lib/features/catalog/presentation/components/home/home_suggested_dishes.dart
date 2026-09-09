import 'package:delivery_app/core/design_system/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'home_mock_data.dart';
import 'home_mock_sheet.dart';
import 'home_style.dart';
import '../../../application/home_suggested_dish.dart';

class HomeSuggestedDishes extends StatelessWidget {
  const HomeSuggestedDishes({
    super.key,
    required this.onSeeAll,
    required this.onRestaurantSelected,
    this.dishes = const [],
  });
  final VoidCallback onSeeAll;
  final ValueChanged<num> onRestaurantSelected;
  final List<HomeSuggestedDish> dishes;
  List<HomeSuggestedDish> get items =>
      dishes.isEmpty ? homeSuggestedDishes : dishes;
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: HomeStyle.surface(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 16),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hôm nay ăn gì?',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                style: TextButton.styleFrom(
                  minimumSize: const Size(0, 32),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  S.of(context).pilotHomeSeeAll,
                  style: TextStyle(
                    fontSize: 11,
                    color: HomeStyle.muted(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 96 + 52 * MediaQuery.textScalerOf(context).scale(1),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final dish = items[index];
                return SizedBox(
                  width: 112,
                  child: InkWell(
                    onTap: () {
                      final restaurantId = dish.restaurantId;
                      if (restaurantId == null || restaurantId <= 0) {
                        showHomeMockSheet(context, dish.name);
                        return;
                      }
                      onRestaurantSelected(restaurantId);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppContentImage(
                          imageUrl: dish.image,
                          semanticLabel: dish.name,
                          width: 112,
                          height: 96,
                          borderRadius: HomeStyle.controlRadius,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          dish.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${NumberFormat.decimalPattern('vi').format(dish.price)}đ',
                          style: TextStyle(
                            fontSize: 12,
                            color: HomeStyle.accent(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
