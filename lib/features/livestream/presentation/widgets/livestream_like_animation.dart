import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget animation trái tim bay lên khi like
class LivestreamLikeAnimation extends StatefulWidget {
  const LivestreamLikeAnimation({super.key});

  @override
  State<LivestreamLikeAnimation> createState() => _LivestreamLikeAnimationState();
}

class _LivestreamLikeAnimationState extends State<LivestreamLikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late double _randomX;

  @override
  void initState() {
    super.initState();

    // Random horizontal position
    _randomX = Random().nextDouble() * 0.6 + 0.2; // 20% - 80% of screen width

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Position animation (bottom to top)
    _positionAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Opacity animation (fade in then fade out)
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 20,
      ),
    ]).animate(_controller);

    // Scale animation (small to big)
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          right: MediaQuery.of(context).size.width * _randomX,
          bottom: MediaQuery.of(context).size.height * _positionAnimation.value * 0.5,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 40.w,
              ),
            ),
          ),
        );
      },
    );
  }
}
