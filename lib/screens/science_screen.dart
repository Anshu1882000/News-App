import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/loader.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Expanded(
      child: FutureBuilder(
        future: newsProvider.scienceNews.isEmpty
            ? newsProvider.getAndFetchNews('science')
            : Future.value(true),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Loader()
            : Consumer<NewsProvider>(
                builder: (context, newsItem, child) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: RefreshIndicator(
                    onRefresh: () => newsProvider.getAndFetchNews('science'),
                    displacement: 2,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NewsCard(
                          news: newsItem.scienceNews[index],
                        );
                      },
                      itemCount: newsItem.scienceNews.length,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
