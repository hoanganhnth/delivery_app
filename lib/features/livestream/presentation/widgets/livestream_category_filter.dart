import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/generated/l10n.dart';

class LivestreamCategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const LivestreamCategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    
    // Khởi tạo danh sách category với localized labels
    final List<Map<String, dynamic>> categoryData = [
      {'icon': Icons.restaurant_menu, 'id': 'All', 'label': s.livestreamFilterAll},
      {'icon': Icons.local_fire_department, 'id': 'Street Food', 'label': s.livestreamFilterStreetFood},
      {'icon': Icons.dining, 'id': 'Fine Dining', 'label': s.livestreamFilterFineDining},
      {'icon': Icons.cake, 'id': 'Baking', 'label': s.livestreamFilterBaking},
      {'icon': Icons.icecream, 'id': 'Desserts', 'label': s.livestreamFilterDesserts},
      {'icon': Icons.local_cafe, 'id': 'Drinks', 'label': s.livestreamFilterDrinks},
    ];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categoryData.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final category = categoryData[index];
          final categoryId = category['id'] as String;
          final isActive = categoryId == selectedCategory;
          
          return CategoryPill(
            icon: category['icon'] as IconData,
            label: category['label'] as String,
            isActive: isActive,
            onTap: () => onCategorySelected(categoryId),
          );
        },
      ),
    );
  }
}
