import 'package:flutter/material.dart';

class NewsItemImage extends StatelessWidget {
  final String image;
  final double radius;

  NewsItemImage(this.image, {Key key, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: image != null
          ? Image(image: NetworkImage(image))
          : Image(image: AssetImage('images/goorla_news.png')),
      borderRadius: radius != null ? BorderRadius.circular(radius) : BorderRadius.zero,
    );
  }
}
