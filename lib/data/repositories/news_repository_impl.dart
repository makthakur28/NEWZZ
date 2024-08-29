// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_app/business/repositories/news_repository.dart';
import 'package:news_app/data/sources/remote/api_service.dart';
import 'package:news_app/data/models/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiService apiService;
  NewsRepositoryImpl({
    required this.apiService,
  });
  @override
  Future<List<NewsArticle>> getLatestNews() async {
    return apiService.fetchLatestNews();
  }

  @override
  Future<List<NewsArticle>> getBreakingNews() async {
    return apiService.fetchBreakingNews();
  }

  @override
  Future<List<NewsArticle>> getCategoryNews(String category) {
    return apiService.fetchCategoryNews(category);
  }

  @override
  Future<List<NewsArticle>> getTrendingNews() {
    return apiService.fetchTrendingNews();
  }
}
