import 'package:flutter/material.dart';
import 'package:news_app/widgets/show_dialogue.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../widgets/news_card.dart';
import '../widgets/loader.dart';

class GeneralNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return Expanded(
      child: FutureBuilder(
        future: newsProvider.generalNews.isEmpty
            ? newsProvider.getAndFetchNews('general').catchError((error) => showCustomDialogue(context, error))
            : Future.value(true),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Loader()
            : Consumer<NewsProvider>(
                builder: (context, newsItem, child) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: RefreshIndicator(
                    onRefresh: () => newsProvider.getAndFetchNews('general').catchError((error) => showCustomDialogue(context, error)),
                    displacement: 2,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NewsCard(
                          news: newsItem.generalNews[index],
                        );
                      },
                      itemCount: newsItem.generalNews.length,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
