import 'package:cached_network_image/cached_network_image.dart';
import 'package:dyd/core/config/extension/extension.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_palette.dart';
import '../../typo/black_typo.dart';

class CNetworkImageWithTextWidget extends StatelessWidget {
  final String imageLink;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final String name;
  final TextStyle? style;
  final Color color;

  const CNetworkImageWithTextWidget({
    super.key,
    required this.imageLink,
    this.width,
    this.radius = 15,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.height,
    required this.name,
    this.style,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    String defaultProfileAlphabet = "";
    if (name.isNotEmpty) {
      String firstName = name.split(" ")[0];
      String firstLetter = firstName[0];
      defaultProfileAlphabet = firstLetter;
    }
    return ClipOval(
      child: ColoredBox(
        color: color,
        child: SizedBox(
            height: height,
            width: width,
            child: imageLink == ""
                ?
                // CircleAvatar(
                //       radius: 35,
                //       backgroundColor: AppPalette.lightGrey,
                //       child: Icon(Icons.person, color: AppPalette.white, size: 50),
                //     )
                Center(
                    child: Text(defaultProfileAlphabet.capitalizeFirstLetter(),
                        style: style ?? TypoBlack.black50014),
                  )
                : CachedNetworkImage(
                    imageUrl: imageLink,
                    fit: fit,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: AppPalette.primaryColor1),
                    ),
                  )),
      ),
    );
  }
}

class CNetworkImageRectangularWithTextWidget extends StatelessWidget {
  final String imageLink;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;
  final BorderRadiusGeometry borderRadius;
  final String name;
  final TextStyle? style;
  final Color color;
  final bool showFullTitle;

  const CNetworkImageRectangularWithTextWidget({
    super.key,
    required this.imageLink,
    this.width,
    this.radius = 15,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.height,
    required this.name,
    this.style,
    this.color = Colors.transparent,
    this.showFullTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    String defaultProfileAlphabet = "";
    if (name.isNotEmpty) {
      String firstName = name.trim().split(" ")[0];
      String firstLetter = firstName[0];
      defaultProfileAlphabet = firstLetter;
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: color,
        child: SizedBox(
            height: height,
            width: width,
            child: imageLink == ""
                ? Center(
                    child: Text(
                        showFullTitle
                            ? name.capitalizeFirstLetter()
                            : defaultProfileAlphabet.capitalizeFirstLetter(),
                        style: style ?? TypoBlack.black50014),
                  )
                : CachedNetworkImage(
                    imageUrl: imageLink,
                    fit: fit,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const Center(
                      child: CircularProgressIndicator(
                          color: AppPalette.primaryColor1),
                    ),
                  )),
      ),
    );
  }
}
