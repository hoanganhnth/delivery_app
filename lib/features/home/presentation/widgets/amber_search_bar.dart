import 'package:flutter/material.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

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
    this.showButton = true,
    this.buttonText = 'Find',
  });

  @override
  State<AmberSearchBar> createState() => _AmberSearchBarState();
}

class _AmberSearchBarState extends State<AmberSearchBar> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    widget.onSearch?.call(_controller.text);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: _isFocused
            ? Border.all(
                color: context.colors.primary.withValues(alpha: 0.5),
                width: 2,
              )
            : null,
      ),
      child: Row(
        children: [
          // Search icon
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.search,
              color: context.colors.primary,
              size: 24,
            ),
          ),
          
          // Text field
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: (value) => _handleSearch(),
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C160D),
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: context.colors.secondary.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
            ),
          ),
          
          // Find button
          if (widget.showButton)
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: _handleSearch,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.buttonText,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
