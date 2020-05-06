import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsItemImage extends StatelessWidget {
  final String image;
  final double radius;
  final double height;
  final double width;

  NewsItemImage(this.image, {Key key, this.radius, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: kIsWeb ? getImage() : getCachedImage(),
      borderRadius:
          radius != null ? BorderRadius.circular(radius) : BorderRadius.zero,
    );
  }

  Widget getImage() {
    return image != null
        ? height != null && width != null
            ? Image(
                image: NetworkImage(image),
                height: height,
                width: width,
                fit: BoxFit.cover,
              )
            : Image(image: NetworkImage(image))
        : getDefaultImage();
  }

  Widget getCachedImage() {
    return image != null
        ? height != null && width != null
            ? CachedNetworkImage(
                imageUrl: image,
                height: height,
                width: width,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    center(CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    center(Image(image: AssetImage('images/goorla_news.png'))))
            : CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    center(CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    center(Image(image: AssetImage('images/goorla_news.png'))))
        : getDefaultImage();
  }

  Widget getDefaultImage() {
    return height != null && width != null
        ? Image(
            image: AssetImage('images/goorla_news.png'),
            height: height,
            width: width,
            fit: BoxFit.cover,
          )
        : Image(image: AssetImage('images/goorla_news.png'));
  }

  center(Widget widget) => Container(
      height: 200, color: Colors.grey[200], child: Center(child: widget));
}
