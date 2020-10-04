import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

Widget cachedDownloadableImage({
  @required String imageURL,
  @required double height,
  @required double width,
  BoxShape shape,
  BoxFit fit,
  BoxBorder border,
}) {
  return Container(
    height: height,
    width: width,
    alignment: Alignment.center,
    child: CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border ?? Border(),
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
              image: imageProvider, fit: fit ?? BoxFit.scaleDown),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          Icon(Icons.error_outline, color: Colors.red),
    ),
  );
}
