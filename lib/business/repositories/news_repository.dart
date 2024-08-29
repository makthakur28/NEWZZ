import 'package:news_app/data/models/news_article_model.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getLatestNews();
  Future<List<NewsArticle>> getBreakingNews();
  Future<List<NewsArticle>> getCategoryNews(String category);
  Future<List<NewsArticle>> getTrendingNews();
}
