import 'package:flutter/material.dart';

/// Custom clipper for asymmetric polygon shape
/// 
/// Creates a polygon path: (0,0) → (width,0) → (width,85%) → (0,100%)
/// Used for hero section on login screen to create diagonal edge effect
class AsymmetricClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.85);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
