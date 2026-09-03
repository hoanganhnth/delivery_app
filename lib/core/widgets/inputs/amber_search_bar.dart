import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';

/// Amber Hearth style search bar
///
/// Features:
/// - Elevated white background with shadow-md
/// - Border radius: 12px (rounded-xl)
/// - Height: 56px (h-14)
/// - Inner "Find" button with primary color
/// - Focus ring: primary/50 opacity
/// - Search icon prefix
class AmberSearchBar extends StatefulWidget {
  /// Placeholder text
  final String placeholder;

  /// Text editing controller
  final TextEditingController? controller;

  /// Callback when search is submitted (via button or enter)
  final ValueChanged<String>? onSearch;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Optional tap handler for a read-only launcher variant.
  final VoidCallback? onTap;

  /// Whether to show the Find button
  final bool showButton;

  /// Button text (default: "Find")
  final String buttonText;

  const AmberSearchBar({
    super.key,
    this.placeholder = 'What are you craving today?',
    this.controller,
    this.onSearch,
    this.onChanged,
    this.onTap,
    this.showButton = true,
    this.buttonText = 'Find',
  });

  @override
  State<AmberSearchBar> createState() => _AmberSearchBarState();
}

class _AmberSearchBarState extends State<AmberSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleSearch() {
    widget.onSearch?.call(_controller.text);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppSearchField(
            controller: _controller,
            hintText: widget.placeholder,
            semanticLabel: widget.placeholder,
            readOnly: widget.onTap != null,
            onTap: widget.onTap,
            onChanged: (value) {
              widget.onChanged?.call(value);
              setState(() {});
            },
            onSubmitted: (_) => _handleSearch(),
          ),
        ),
        if (widget.showButton) ...[
          const SizedBox(width: AppSpacing.xs),
          AppButton(label: widget.buttonText, onPressed: _handleSearch),
        ],
      ],
    );
  }
}
