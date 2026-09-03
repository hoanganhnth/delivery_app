import 'package:flutter/material.dart';

import '../foundations/app_radii.dart';

class AppContentImage extends StatelessWidget {
  const AppContentImage({
    super.key,
    required this.imageUrl,
    required this.semanticLabel,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = AppRadii.card,
    this.placeholderIcon = Icons.restaurant_outlined,
  });

  final String? imageUrl;
  final String semanticLabel;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final IconData placeholderIcon;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();
    return Semantics(
      image: true,
      label: semanticLabel,
      child: ExcludeSemantics(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox(
            width: width,
            height: height,
            child: url == null || url.isEmpty
                ? _fallback(context)
                : Image.network(
                    url,
                    width: width,
                    height: height,
                    fit: fit,
                    frameBuilder: (context, child, frame, wasLoaded) =>
                        frame == null && !wasLoaded
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              _fallback(context),
                              const Center(
                                child: SizedBox.square(
                                  dimension: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : child,
                    errorBuilder: (_, _, _) => _fallback(context),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _fallback(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    child: Center(
      child: Icon(
        placeholderIcon,
        size: 40,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ),
  );
}
