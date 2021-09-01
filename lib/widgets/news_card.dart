import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/news_detail.dart';

import '../models/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  NewsCard({this.news});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(NewsDetail.routeName, arguments: {"news": news});
        },
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: news.title,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: news.urlToImage,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => Image.asset("images/placeholder.png"),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      news.title,
                      overflow: TextOverflow.clip,
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}