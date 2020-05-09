import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsItemImage extends StatelessWidget {
  final String image;
  final double radius;
  final bool mini;

  NewsItemImage(this.image, {Key key, this.radius, this.mini})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: mini ? 100 : 250,
        width: mini ? 100 : MediaQuery.of(context).size.width,
        child: ClipRRect(
          child: kIsWeb ? getImage() : getCachedImage(),
          borderRadius: radius != null
              ? BorderRadius.circular(radius)
              : BorderRadius.zero,
        ));
  }

  Widget getImage() {
    return image != null
        ? Image(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          )
        : getDefaultImage();
  }

  Widget getCachedImage() {
    return image != null
        ? CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) => center(CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                center(Image(image: AssetImage('images/goorla_news.png'))))
        : getDefaultImage();
  }

  Widget getDefaultImage() {
    return Image(
        image: AssetImage('images/goorla_news.png'), fit: BoxFit.cover);
  }

  center(Widget widget) => Container(
      height: 200, color: Colors.grey[200], child: Center(child: widget));
}
