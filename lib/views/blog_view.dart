import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'article_view.dart';

class BlogTitle extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTitle(
      {required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Column(
          children: <Widget>[
            ClipRect(
              clipBehavior: Clip.hardEdge,
            ),
            CachedNetworkImage(imageUrl: imageUrl),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}