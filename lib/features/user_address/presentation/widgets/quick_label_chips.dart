import 'package:flutter/material.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

/// Quick Label ChoiceChips - Nhà riêng, Công ty, Trường học, Khác
class QuickLabelChips extends StatelessWidget {
  final String selectedLabel;
  final ValueChanged<String> onSelected;

  const QuickLabelChips({
    super.key,
    required this.selectedLabel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final labels = ['Nhà riêng', 'Công ty', 'Trường học', 'Khác'];

    return Wrap(
      spacing: ResponsiveSize.s,
      runSpacing: ResponsiveSize.s,
      children: labels.map((label) {
        final isSelected = selectedLabel == label;
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) onSelected(label);
          },
          backgroundColor: colors.cardBackground,
          selectedColor: colors.primary.withValues(alpha: 0.2),
          labelStyle: TextStyle(
            fontSize: ResponsiveSize.fontM,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? colors.primary : colors.textSecondary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
            side: BorderSide(
              color: isSelected ? colors.primary : colors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.m,
            vertical: ResponsiveSize.s,
          ),
        );
      }).toList(),
    );
  }
}
