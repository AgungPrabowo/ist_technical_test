import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final dynamic image;
  final double? height, width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? loadingColor;
  final Widget? loadingWidget, errorWidget;

  const ShowImage({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.loadingWidget,
    this.loadingColor,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errWidget = errorWidget ??
        Icon(
          Icons.image_not_supported_outlined,
          size: fit == BoxFit.fitHeight ? height : width,
          color: Colors.grey,
        );
    if (image is String) {
      var image = this.image as String;
      if (image.isNotEmpty) {
        if (image.startsWith("https") || image.startsWith("http")) {
          return ClipRRect(
            borderRadius: borderRadius,
            child: CachedNetworkImage(
              imageUrl: image,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, url) {
                return loadingWidget ??
                    Center(
                      child: CircularProgressIndicator(
                        color: loadingColor,
                      ),
                    );
              },
              errorWidget: (context, _, x) {
                return errWidget;
              },
            ),
          );
        }
      }
    } else if (image is Uint8List) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.memory(
          image,
          height: height,
          width: width,
          fit: fit,
        ),
      );
    }
    return errWidget;
  }
}
