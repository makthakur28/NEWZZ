// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/business/usecases/get_breaking_news.dart';
import 'package:news_app/business/usecases/get_category_news.dart';
import 'package:news_app/business/usecases/get_channels_list.dart';

import 'package:news_app/business/usecases/get_latesh_news.dart';
import 'package:news_app/business/usecases/get_trending_news.dart';
import 'package:news_app/data/models/news_article_model.dart';
import 'package:news_app/data/models/news_sources_model.dart';

class NewsProviders extends ChangeNotifier {
  final GetLatestNewsUseCase getLatestNewsUseCase;
  final GetBreakingNews getBreakingNews;
  final GetCategorySpecificNews getCategorySpecificNews;
  final GetTrendingNews getTrendingNews;
  final GetChannelsList getChannelsList;
  List<NewsArticle> topHeadlinesArticles = [];
  List<NewsArticle> breakingNewsArticles = [];
  List<NewsArticle> categorySpecificArticles = [];
  List<NewsArticle> trendingNewsArticles = [];
  List<NewsChannelsModel> channelsList = [];

  List<String> categories = [
    'General',
    'Technology',
    'Entertainment',
    'Business',
    'Sports',
    'Politics'
  ];
  Map<String, bool> categoryMap = {
    'General': false,
    'Technology': false,
    'Entertainment': false,
    'Business': false,
    'Sports': false,
    'Politics': false,
  };
  String selectedIndex = 'Entertainment';
  bool isLoadingHome = false;
  bool isLoadingCategory = false;
  bool isLoadingTrending = false;
  bool isLoadingChannel = false;
  NewsProviders(
      {required this.getLatestNewsUseCase,
      required this.getBreakingNews,
      required this.getCategorySpecificNews,
      required this.getTrendingNews,
      required this.getChannelsList});

  updateCategoryList(category) {
    categoryMap[selectedIndex] = false;
    categoryMap[category] = true;
    selectedIndex = category;
  }

  Future<void> loadTopHeadlines() async {
    isLoadingHome = true;
    notifyListeners();
    topHeadlinesArticles = await getLatestNewsUseCase.execute();
    debugPrint(topHeadlinesArticles[0].title);
    isLoadingHome = false;
    notifyListeners();
  }

  Future<void> loadBreakingNews() async {
    isLoadingHome = true;
    notifyListeners();
    breakingNewsArticles = await getBreakingNews.execute();
    debugPrint('Breaking news 1 : ${breakingNewsArticles[0].title}');
    isLoadingHome = false;
    notifyListeners();
  }

  Future<void> loadCategoryNews(String category) async {
    isLoadingCategory = true;
    notifyListeners();
    updateCategoryList(category);
    categorySpecificArticles = await getCategorySpecificNews.execute(category);
    debugPrint('Category news 1 : ${categorySpecificArticles[0].title}');
    isLoadingCategory = false;
    notifyListeners();
  }

  Future<void> loadTrendingNews() async {
    isLoadingTrending = true;
    notifyListeners();
    trendingNewsArticles = await getTrendingNews.execute();
    isLoadingTrending = false;
    notifyListeners();
  }

  Future<void> loadChannelList() async {
    isLoadingChannel = true;
    notifyListeners();
    channelsList = await getChannelsList.execute();
    isLoadingChannel = false;
    notifyListeners();
  }
}
