import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CCachedNetworkImage extends StatelessWidget {
  final String imageLink;
  final BoxFit fit;

  const CCachedNetworkImage(
      {super.key, required this.imageLink, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageLink,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
      const Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
      errorWidget: (context, url, error) =>const Icon(Icons.image_not_supported_outlined),
    );
  }
}
