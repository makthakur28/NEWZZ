import 'package:dio/dio.dart';
import 'package:news_app/core/api/api_constants.dart';
import 'package:news_app/data/models/news_article_model.dart';
import 'package:news_app/data/models/news_sources_model.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<List<NewsArticle>> fetchLatestNews() async {
    try {
      final response = await dio.get('$baseUrl/top-headlines',
          queryParameters: {'sources': 'google-news', 'apiKey': apiKey});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];
        return data.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news !! ');
      }
    } catch (e) {
      throw Exception('Dio Error : $e');
    }
  }

  Future<List<NewsArticle>> fetchBreakingNews() async {
    try {
      final response = await dio.get('$baseUrl/top-headlines',
          queryParameters: {'sources': 'bbc-news', 'apiKey': apiKey});
      // print("Response Status Code: ${response.data}");
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];
        return data.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news !! ');
      }
    } catch (e) {
      throw Exception('Dio Error : $e');
    }
  }

  Future<List<NewsArticle>> fetchCategoryNews(String category) async {
    try {
      final response = await dio.get('$baseUrl/everything',
          queryParameters: {'q': category, 'apiKey': apiKey});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];
        return data.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load Category news');
      }
    } catch (e) {
      throw Exception('Dio Exception : $e');
    }
  }

  Future<List<NewsArticle>> fetchTrendingNews() async {
    try {
      final response = await dio.get('$baseUrl/top-headlines',
          queryParameters: {'country': 'us', 'apiKey': apiKey});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];
        return data.map((article) => NewsArticle.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load Trending News');
      }
    } catch (e) {
      throw Exception('Dio Exception : $e');
    }
  }

  Future<List<NewsChannelsModel>> fetchChannelList() async {
    try {
      final response = await dio.get('$baseUrl/top-headlines/sources',
          queryParameters: {'apiKey': apiKey});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['sources'];
        return data
            .map((channel) => NewsChannelsModel.fromJson(channel))
            .toList();
      } else {
        throw Exception("Unable to get Channels list");
      }
    } catch (e) {
      throw Exception("Dio eroor: $e");
    }
  }
}
