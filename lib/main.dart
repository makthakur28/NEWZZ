import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/business/usecases/get_breaking_news.dart';
import 'package:news_app/business/usecases/get_category_news.dart';
import 'package:news_app/business/usecases/get_channels_list.dart';
import 'package:news_app/business/usecases/get_latesh_news.dart';
import 'package:news_app/business/usecases/get_trending_news.dart';
import 'package:news_app/data/repositories/channel_repository_impl.dart';
import 'package:news_app/data/repositories/news_repository_impl.dart';
import 'package:news_app/data/sources/remote/api_service.dart';
import 'package:news_app/presentation/providers/news_providers.dart';
import 'package:news_app/presentation/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();
  final apiService = ApiService(dio: dio);
  final repository = NewsRepositoryImpl(apiService: apiService);
  final channelrepo = ChannelRepositoryImpl(apiService: apiService);
  final getLatestNewsUseCase = GetLatestNewsUseCase(repository: repository);
  final getBreakingNewsUseCase = GetBreakingNews(repository: repository);
  final getCategoryNewsUseCase =
      GetCategorySpecificNews(repository: repository);
  final getTrendingNewsUseCase = GetTrendingNews(repository: repository);
  final getChannelListUseCase = GetChannelsList(repository: channelrepo);
  runApp(ChangeNotifierProvider(
    create: (context) => NewsProviders(
        getLatestNewsUseCase: getLatestNewsUseCase,
        getBreakingNews: getBreakingNewsUseCase,
        getCategorySpecificNews: getCategoryNewsUseCase,
        getTrendingNews: getTrendingNewsUseCase,
        getChannelsList: getChannelListUseCase),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen());
  }
}
