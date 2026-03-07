import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;

  const CustomCachedImage({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: url,
      fit: fit,
      // FIX: Use a simple colored box.
      // Skeletonizer will automatically shimmer this box if enabled.
      placeholder: (context, url) => Container(
        height: height,
        width: width,
        color: Colors.white, // Use white/transparent so shimmer is visible
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        color: Colors.grey[200],
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
