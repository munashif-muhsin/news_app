import 'package:flutter/material.dart';

class Headline {
  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishedDate;

  Headline({
    @required this.author,
    @required this.description,
    @required this.imageUrl,
    @required this.publishedDate,
    @required this.title,
  })  : assert(author != null),
        assert(description != null),
        assert(imageUrl != null),
        assert(publishedDate != null),
        assert(title != null);
}
