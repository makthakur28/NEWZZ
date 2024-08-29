import 'package:news_app/business/repositories/news_repository.dart';
import 'package:news_app/data/models/news_article_model.dart';

class GetBreakingNews {
  NewsRepository repository;

  GetBreakingNews({required this.repository});

  Future<List<NewsArticle>> execute(){
    return repository.getBreakingNews();
  }
}
