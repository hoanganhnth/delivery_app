import 'package:flutter/material.dart';

/// Live indicator badge với animation
/// Hiển thị "LIVE" text với pulsing red dot
class LiveIndicatorBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? dotColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final bool showDot;

  const LiveIndicatorBadge({
    super.key,
    this.text = 'LIVE',
    this.backgroundColor,
    this.textColor,
    this.dotColor,
    this.padding,
    this.fontSize,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFBA1A1A), // Red cho LIVE
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? const Color(0xFFBA1A1A)).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            _PulsingDot(color: dotColor ?? Colors.white),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated pulsing dot
class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8,
      height: 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsing outer circle
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 1 - _controller.value * 0.75),
                ),
              );
            },
          ),
          // Solid inner circle
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
