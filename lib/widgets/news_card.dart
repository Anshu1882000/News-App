import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/news_detail.dart';
import 'package:intl/intl.dart';
import '../models/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  NewsCard({this.news});

  @override
  Widget build(BuildContext context) {
    final _publishedAt =
        DateFormat.yMMMMd().format(DateTime.parse(news.publishedAt));
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
                        placeholder: (context, url) =>
                            Image.asset("images/placeholder.png"),
                        errorWidget: (context, url, error) =>
                            Image.asset("images/placeholder.png"),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    news.title,
                    overflow: TextOverflow.clip,
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (news.publishedAt != null)
                        Container(
                          child: Text(
                            _publishedAt,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.black87,
                          ),
                          onPressed: null),
                      IconButton(
                          icon: Icon(
                            Icons.favorite_outline,
                            color: Colors.black87,
                          ),
                          onPressed: () => Provider.of<NewsProvider>(context,listen: false).addFavorites(news))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
