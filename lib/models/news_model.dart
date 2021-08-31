import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsModel {
  String source;
  String title;
  String description;
  String more;
  String imageUrl;
  String content;
  String author;
  String publishedAt;

  NewsModel(
      {@required this.title,
      @required this.description,
      this.more,
      this.imageUrl,
      this.content,
      this.author,
      this.publishedAt,
      this.source});
}

class NewsProvider with ChangeNotifier {
  List<NewsModel> _generalNews = [];
  List<NewsModel> _sportsNews = [];
  List<NewsModel> _techNews = [];
  List<NewsModel> _healthNews = [];
  List<NewsModel> _entertainmentNews = [];
  List<NewsModel> _scienceNews = [];
  List<NewsModel> _businessNews = [];
  List<NewsModel> _searchResult = [];

  List<NewsModel> get searchResult {
    return [..._searchResult];
  }

  List<NewsModel> get generalNews {
    return [..._generalNews];
  }

  List<NewsModel> get sportsNews {
    return [..._sportsNews];
  }

  List<NewsModel> get techNews {
    return [..._techNews];
  }

  List<NewsModel> get healthNews {
    return [..._healthNews];
  }

  List<NewsModel> get entertainmentNews {
    return [..._entertainmentNews];
  }

  List<NewsModel> get scienceNews {
    return [..._scienceNews];
  }

  List<NewsModel> get businessNews {
    return [..._businessNews];
  }

  Future<void> getAndFetchNews(category) async {
    try {
      final newsUrl = Uri.parse(
          'https://newsapi.org/v2/top-headlines?apiKey=9a420f1e32e64332aca15d4fcb43b5a4&category=$category&country=in');

      final _newsResponse = await http.get(newsUrl);
      final _newsBody = json.decode(_newsResponse.body);
      final _newsList = _newsBody['articles'] as List<dynamic>;
      final tempnews = _newsList
          .map(
            (news) => NewsModel(
                description: news['description'],
                title: news['title'],
                content: news['content'],
                imageUrl: news['urlToImage'],
                more: news['url'],
                author: news['author'],
                publishedAt: news['publishedAt']),
          )
          .toList();
      switch (category) {
        case 'technology':
          {
            _techNews = tempnews;
          }
          break;
        case 'general':
          {
            _generalNews = tempnews;
          }
          break;
        case 'sports':
          {
            _sportsNews = tempnews;
          }
          break;
        case 'health':
          {
            _healthNews = tempnews;
          }
          break;
        
        case 'science':
          {
            _scienceNews = tempnews;
          }
          break;
        case 'business':
          {
            _businessNews = tempnews;
          }
          break;
        case 'entertainment':
          {
            _entertainmentNews = tempnews;
          }
          break;
      }



      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getsearchResult(query) async {
    try {
      final newsUrl = Uri.parse(
          'https://newsapi.org/v2/top-headlines?apiKey=9a420f1e32e64332aca15d4fcb43b5a4&category=general&q=$query&country=in');

      final _newsResponse = await http.get(newsUrl);
      final _newsBody = json.decode(_newsResponse.body);
      final _newsList = _newsBody['articles'] as List<dynamic>;      _searchResult = _newsList
          .map(
            (news) => NewsModel(
                description: news['description'],
                title: news['title'],
                content: news['content'],
                imageUrl: news['urlToImage'],
                more: news['url'],
                author: news['author'],
                publishedAt: news['publishedAt']),
          )
          .toList();
     

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }


}