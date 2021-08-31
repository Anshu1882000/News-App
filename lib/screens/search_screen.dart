import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  Future<void> _getAndFetchNews(context, query) {
    print(query);
    return Provider.of<NewsProvider>(context, listen: false)
        .getsearchResult(query)
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
                          await _getAndFetchNews(context, query);
                        }),
                  ],
                ),
              ),
            });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search for topics, locations & sources',
            border: InputBorder.none,
          ),
        ),
      ),
      body: FutureBuilder(
              future: _getAndFetchNews(context, query),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<NewsProvider>(
                      builder: (context, newsItem, child) => Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: newsItem.searchResult.length == 0
                            ? Center(
                                child:
                                    Image.asset("images/no-search-result.png"))
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsCard(
                                    news: newsItem.searchResult[index],
                                  );
                                },
                                itemCount: newsItem.searchResult.length,
                              ),
                      ),
                    ),
            )
          
    );
  }
}
