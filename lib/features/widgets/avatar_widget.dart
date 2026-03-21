import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarWidgetSize {
  s30(30),
  s60(60),
  s90(90),
  s120(120);

  const AvatarWidgetSize(this.value);

  final double value;
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.imageUrl,
    this.size = AvatarWidgetSize.s60,
    this.borderRadius,
    this.backgroundColor,
  });

  final String? imageUrl;
  final AvatarWidgetSize size;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final dimension = size.value;
    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(dimension / 2);
    final resolvedBackgroundColor = backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;

    return SizedBox(
      width: dimension,
      height: dimension,
      child: ClipRRect(
        borderRadius: resolvedBorderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(color: resolvedBackgroundColor),
          child: _hasImage
              ? CachedNetworkImage(
                  imageUrl: 'http://172.18.0.1:8080$imageUrl',
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 180),
                  placeholder: (context, url) => _AvatarLoadingWidget(size: dimension),
                  errorWidget: (context, url, error) => _AvatarFallbackWidget(size: dimension),
                )
              : _AvatarFallbackWidget(size: dimension),
        ),
      ),
    );
  }

  bool get _hasImage => imageUrl != null && imageUrl!.trim().isNotEmpty;
}

class _AvatarLoadingWidget extends StatelessWidget {
  const _AvatarLoadingWidget({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final indicatorSize = size * 0.32;

    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: const CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}

class _AvatarFallbackWidget extends StatelessWidget {
  const _AvatarFallbackWidget({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.person_rounded, size: size * 0.42, color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}
