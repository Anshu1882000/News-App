import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/loader.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/widgets/show_dialogue.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return FutureBuilder(
      future: newsProvider
              .getFavourites()
              .catchError((error) => showCustomDialogue(context, error)),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Loader()
              : Consumer<NewsProvider>(
                  builder: (context, newsItem, child) => Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NewsCard(
                          news: newsItem.getNews("favorites")[index],
                        );
                      },
                      itemCount: newsItem.getNews("favorites").length,
                    ),
                  ),
                ),
    );
  }
}