import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppImage extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useCache; // ✅ mới thêm

  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
    this.placeholder,
    this.errorWidget,
    this.useCache = true, // ✅ mặc định có cache
  });

  bool get _isNetwork =>
      path != null &&
      (path!.startsWith("http://") || path!.startsWith("https://"));

  bool get _isFile =>
      path != null && (path!.startsWith("/") || path!.startsWith("file://"));

  bool get _isAsset => path != null && !_isNetwork && !_isFile;

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return _buildError();
    }

    Widget image;

    if (_isNetwork) {
      if (useCache) {
        image = CachedNetworkImage(
          imageUrl: path!,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, _) => placeholder ??
              Container(
                width: width,
                height: height,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
          errorWidget: (context, _, __) => errorWidget ?? _buildError(),
        );
      } else {
        image = Image.network(
          path!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => errorWidget ?? _buildError(),
        );
      }
    } else if (_isFile) {
      image = Image.file(
        File(path!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorWidget ?? _buildError(),
      );
    } else if (_isAsset) {
      image = Image.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorWidget ?? _buildError(),
      );
    } else {
      image = _buildError();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );
  }

  Widget _buildError() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, color: Colors.grey, size: 32),
    );
  }
}
