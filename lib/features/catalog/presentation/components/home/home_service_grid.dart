import 'package:flutter/material.dart';
import 'home_style.dart';

class HomeServiceGrid extends StatelessWidget {
  const HomeServiceGrid({super.key, required this.onCategorySelected});
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: HomeStyle.surface(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final service in const [
            (Icons.restaurant_outlined, 'Tất cả', Color(0xFFE55C31)),
            (Icons.ramen_dining_outlined, 'Mì & phở', Color(0xFFC99822)),
            (Icons.rice_bowl_outlined, 'Cơm & bún', Color(0xFF3D9C80)),
            (Icons.bakery_dining_outlined, 'Bánh cuốn', Color(0xFFCB6A53)),
            (Icons.cookie_outlined, 'Ăn vặt', Color(0xFFE55C31)),
          ])
            Expanded(
              child: _ServiceTile(
                icon: service.$1,
                label: service.$2,
                accent: service.$3,
                onTap: () => onCategorySelected(service.$2),
              ),
            ),
        ],
      ),
    ),
  );
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.label,
    required this.accent,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    child: InkWell(
      onTap: onTap,
      borderRadius: HomeStyle.controlRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: accent, size: 28),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    ),
  );
}
