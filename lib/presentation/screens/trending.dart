import 'package:flutter/material.dart';
import 'package:news_app/presentation/providers/news_providers.dart';
import 'package:news_app/presentation/widgets/ternding_card.dart';
import 'package:news_app/presentation/widgets/webviewwidget.dart';
import 'package:provider/provider.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<NewsProviders>(context, listen: false).loadTrendingNews(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(8),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Text(
              'Trending Now',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'monospace'),
            ),
          ),
          Consumer<NewsProviders>(
            builder: (context, newsProvider, child) => SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: newsProvider.trendingNewsArticles.length,
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Webviewwidget(
                                  webUrl: newsProvider
                                      .trendingNewsArticles[index].url
                                      .toString())));
                    },
                    child: Hero(
                      tag:
                          'Card${newsProvider.trendingNewsArticles[index].url}',
                      child: Container(
                        child: trendingCard(
                            newsProvider.trendingNewsArticles[index].urltoImage,
                            newsProvider.trendingNewsArticles[index].title),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
