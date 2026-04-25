import 'package:flutter/material.dart';

/// Typing indicator với 3 animated dots
/// Sử dụng trong chat để hiển thị khi đối phương đang gõ
class TypingIndicator extends StatefulWidget {
  final Color? dotColor;
  final double dotSize;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const TypingIndicator({
    super.key,
    this.dotColor,
    this.dotSize = 6,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dotColor = widget.dotColor ?? theme.colorScheme.secondary;
    final bgColor = widget.backgroundColor ??
        theme.colorScheme.surfaceContainerHighest;

    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 4 : 0),
            child: _AnimatedDot(
              controller: _controller,
              delay: index * 0.15,
              color: dotColor,
              size: widget.dotSize,
            ),
          );
        }),
      ),
    );
  }
}

class _AnimatedDot extends StatelessWidget {
  final AnimationController controller;
  final double delay;
  final Color color;
  final double size;

  const _AnimatedDot({
    required this.controller,
    required this.delay,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = controller.value;
        final adjustedValue = ((value - delay) % 1.0).clamp(0.0, 1.0);
        
        // Fade in and out
        final opacity = adjustedValue < 0.5
            ? (adjustedValue * 2)
            : (2 - adjustedValue * 2);

        return Opacity(
          opacity: opacity.clamp(0.3, 1.0),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      },
    );
  }
}
