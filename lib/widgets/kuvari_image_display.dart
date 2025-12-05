import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KuvariImageDisplay extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const KuvariImageDisplay({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (url.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        url,
        fit: fit,
        width: width,
        height: height,
        placeholderBuilder: (BuildContext context) =>
            placeholder ??
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return Image.network(
      url,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? const Icon(Icons.broken_image);
      },
    );
  }
}
