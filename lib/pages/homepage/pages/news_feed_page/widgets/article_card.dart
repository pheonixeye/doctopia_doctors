import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:proklinik_models/models/med_article.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.item,
  });
  final MedArticle item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 8,
      ),
      child: Card.outlined(
        elevation: 0,
        child: ListTile(
          title: Text.rich(
            TextSpan(
                text: item.title,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    html.window.open(item.url, "_blank");
                  },
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                )),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.teaser),
              Text(
                item.from,
                style: const TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
