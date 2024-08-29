import 'package:news_app/business/repositories/news_repository.dart';
import 'package:news_app/data/models/news_article_model.dart';

class GetTrendingNews {
  NewsRepository repository;

  GetTrendingNews({required this.repository});

  Future<List<NewsArticle>> execute() async {
    return repository.getTrendingNews();
  }
}
