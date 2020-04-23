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
      child: image != null
          ? height != null && width != null
              ? Image(
                  image: NetworkImage(image),
                  height: height,
                  width: width,
                )
              : Image(image: NetworkImage(image))
          : height != null && width != null
              ? Image(
                  image: AssetImage('images/goorla_news.png'),
                  height: height,
                  width: width,
                )
              : Image(image: AssetImage('images/goorla_news.png')),
      borderRadius:
          radius != null ? BorderRadius.circular(radius) : BorderRadius.zero,
    );
  }
}
