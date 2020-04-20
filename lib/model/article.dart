import 'package:flutter/material.dart';

@immutable
class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String source;

  Article(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.source});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        author: json['author'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        urlToImage: json['urlToImage'] as String,
        publishedAt: json['publishedAt'] as String,
        source: json['source']['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> article = new Map<String, dynamic>();
    article['author'] = this.author;
    article['title'] = this.title;
    article['description'] = this.description;
    article['url'] = this.url;
    article['urlToImage'] = this.urlToImage;
    article['publishedAt'] = this.publishedAt;
    article['source'] = this.source;
  }
}
