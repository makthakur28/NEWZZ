// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_app/business/repositories/news_repository.dart';
import 'package:news_app/data/models/news_article_model.dart';

class GetCategorySpecificNews {
  NewsRepository repository;
  GetCategorySpecificNews({
    required this.repository,
  });

  Future<List<NewsArticle>> execute(String category) async {
    List<NewsArticle> categorylist = await repository.getCategoryNews(category);

    var list = categorylist.where((item) => item.title != '[Removed]');
    // debugPrint(categorylist);

    return list.toList();
  }
}
