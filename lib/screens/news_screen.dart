import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../widgets/news_card.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = '/news-screen';

  final index;

  NewsScreen({this.index});

  List _category = [
    'general',
    'sports',
    'entertainment',
    'business',
    'health',
    'science',
    'technology'
  ];

  Future<void> _getAndFetchNews(context) {
    return Provider.of<NewsProvider>(context, listen: false)
        .getAndFetchNews(_category[index])
        .catchError((e) => {
              showDialog(
                context: context,
                builder: (BuildContext context) => new AlertDialog(
                  title: new Text(
                    "An error occured",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  content: new Text(e.message),
                  actions: <Widget>[
                    new TextButton(
                        child: new Text("Retry"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _getAndFetchNews(context);
                        }),
                  ],
                ),
              ),
            });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    switch (_category[index]) {
      case 'general':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.generalNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
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
        break;
      case 'entertainment':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.entertainmentNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
                              displacement: 2,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsCard(
                                    news: newsItem.entertainmentNews[index],
                                  );
                                },
                                itemCount: newsItem.entertainmentNews.length,
                              ),
                            ),
                          ),
                        ),
            ),
          );
        }
        break;
      case 'science':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.scienceNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
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
        break;
      case 'technology':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.techNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
                              displacement: 2,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsCard(
                                    news: newsItem.techNews[index],
                                  );
                                },
                                itemCount: newsItem.techNews.length,
                              ),
                            ),
                          ),
                        ),
            ),
          );
        }
        break;
      case 'health':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.healthNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
                              displacement: 2,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsCard(
                                    news: newsItem.healthNews[index],
                                  );
                                },
                                itemCount: newsItem.healthNews.length,
                              ),
                            ),
                          ),
                        ),
            ),
          );
        }
        break;
      case 'business':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.businessNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
                              displacement: 2,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsCard(
                                    news: newsItem.businessNews[index],
                                  );
                                },
                                itemCount: newsItem.businessNews.length,
                              ),
                            ),
                          ),
                        ),
            ),
          );
        }
        break;
      case 'sports':
        {
          return Expanded(
            child: FutureBuilder(
              future: newsProvider.sportsNews.isEmpty
                  ? _getAndFetchNews(context)
                  : Future.value(true),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<NewsProvider>(
                          builder: (context, newsItem, child) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: RefreshIndicator(
                              onRefresh: () => _getAndFetchNews(context),
                              displacement: 2,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsCard(
                                    news: newsItem.sportsNews[index],
                                  );
                                },
                                itemCount: newsItem.sportsNews.length,
                              ),
                            ),
                          ),
                        ),
            ),
          );
        }
        break;
    }
  }
}
