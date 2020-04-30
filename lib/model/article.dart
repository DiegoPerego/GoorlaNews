import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String author;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;

  @HiveField(4)
  String url;

  @HiveField(5)
  String urlToImage;

  @HiveField(6)
  String publishedAt;

  @HiveField(7)
  String source;

  Article(
      {this.id,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.source});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: toMd5(json['url'] as String),
        author: json['author'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        urlToImage: json['urlToImage'] as String,
        publishedAt: json['publishedAt'] as String,
        source: json['source']['name'] as String);
  }

  static String toMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  Article read(BinaryReader reader) {
    return Article()
      ..id = reader.read()
      ..author = reader.read()
      ..title = reader.read()
      ..description = reader.read()
      ..url = reader.read()
      ..urlToImage = reader.read()
      ..publishedAt = reader.read()
      ..source = reader.read();
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Article obj) {
    writer.write(obj.id);
    writer.write(obj.author);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.url);
    writer.write(obj.urlToImage);
    writer.write(obj.publishedAt);
    writer.write(obj.source);
  }
}
