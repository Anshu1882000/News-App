import 'dart:convert';
import '../helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsModel {
  String source;
  String title;
  String description;
  String more;
  String urlToImage;
  String content;
  String author;
  String publishedAt;

  NewsModel(
      {this.title,
      this.description,
      this.more,
      this.urlToImage,
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
  List<NewsModel> _favNews = [];

  List<NewsModel> getNews(category) {
    switch (category) {
      case 'favorites':
        {
          return _favNews;
        }
        break;
      case 'technology':
        {
          return _techNews;
        }
        break;
      case 'general':
        {
          return _generalNews;
        }
        break;
      case 'sports':
        {
          return _sportsNews;
        }
        break;
      case 'health':
        {
          return _healthNews;
        }
        break;

      case 'science':
        {
          return _scienceNews;
        }
        break;
      case 'business':
        {
          return _businessNews;
        }
        break;
      case 'entertainment':
        {
          return _entertainmentNews;
        }
        break;
    }
  }

  // List<NewsModel> get searchResult {
  //   return [..._searchResult];
  // }

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
                urlToImage: news['urlToImage'],
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
          'https://newsapi.org/v2/top-headlines?apiKey=9f63c0261b534d4eb55ff60108320391&category=general&q=$query&country=in');

      final _newsResponse = await http.get(newsUrl);
      final _newsBody = json.decode(_newsResponse.body);
      final _newsList = _newsBody['articles'] as List<dynamic>;
      // _searchResult = _newsList
      //     .map(
      //       (news) => NewsModel(
      //           description: news['description'],
      //           title: news['title'],
      //           content: news['content'],
      //           imageUrl: news['urlToImage'],
      //           more: news['url'],
      //           author: news['author'],
      //           publishedAt: news['publishedAt']),
      //     )
      //     .toList();

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void addFavorites(NewsModel news) {
    DBHelper.insert('fav_news', {
      'id': news.title,
      'title': news.title,
      'description': news.description,
      'more': news.more,
      'image': news.urlToImage,
      'content': news.content,
      'author': news.author,
      'publishedAt': news.publishedAt,
    });
  }

  Future<void> getFavourites() async {
    final dataList = await DBHelper.getData('fav_news');
    _favNews =dataList
        .map(
          (news) => NewsModel(
              description: news['description'],
              title: news['title'],
              content: news['content'],
              urlToImage: news['image'],
              more: news['more'],
              author: news['author'],
              publishedAt: news['publishedAt']),
        )
        .toList();
    
    notifyListeners();
  }
}
