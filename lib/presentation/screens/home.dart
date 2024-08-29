import 'package:flutter/material.dart';
import 'package:news_app/presentation/providers/news_providers.dart';
import 'package:news_app/presentation/screens/categories.dart';
import 'package:news_app/presentation/screens/channels.dart';
import 'package:news_app/presentation/screens/trending.dart';
import 'package:news_app/presentation/widgets/webviewwidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int currentpage = 0;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.initialPage;
    Future.microtask(() =>
        Provider.of<NewsProviders>(context, listen: false).loadTopHeadlines());
    Future.microtask(() =>
        Provider.of<NewsProviders>(context, listen: false).loadBreakingNews());
    currentpage = 0;
  }

  gotoPage(value) {
    setState(() {
      currentpage = value;
      _controller.jumpToPage(currentpage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(
              height: 40,
              // width: 40,
              child: Image.asset('assets/images/logoNewzz.png')),
              const SizedBox(width: 10,),
            const Text(
              "NEWZZ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            currentpage = value;
          });
        },
        children: const [
          Homepage(),
          CategoriesScreen(),
          TrendingScreen(),
          ChannelsScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentpage,
        onTap: (value) {
          gotoPage(value);
        },
        items: 
        const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Trending'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Channels'),
        ],
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProviders>(
      builder: (context, newsProvider, child) {
        if (newsProvider.isLoadingHome) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // if (value.topHeadlinesArticles.isEmpty) {
        //   return const Center(child: Text("No articles found!!"));
        // }
        return Container(
          margin: const EdgeInsets.all(8),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Text(
                  'BREAKING NEWS',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 250,
                child: Consumer<NewsProviders>(
                  builder: (context, newsProvider, child) => ListView.separated(
                    itemCount: newsProvider.breakingNewsArticles.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (newsProvider.breakingNewsArticles[index].urltoImage !=
                          null) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Webviewwidget(
                                      webUrl: newsProvider
                                          .breakingNewsArticles[index].url
                                          .toString()),
                                ));
                          },
                          child: Hero(
                            tag: 'Card${newsProvider.breakingNewsArticles[index].url}',
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              height: 200,
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  // gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6),Colors.grey.withOpacity(0.1)],begin: Alignment.bottomLeft),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image:(newsProvider
                                          .breakingNewsArticles[index]
                                          .urltoImage!=null)?NetworkImage(newsProvider
                                          .breakingNewsArticles[index]
                                          .urltoImage!):const AssetImage('assets/images/NEWZZ.png'),
                                      fit: BoxFit.cover),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF9DBDFF),
                                        offset: Offset(2, 3),
                                        blurRadius: 3)
                                  ]),
                              child: Stack(
                                children: [
                                  Container(
                                      // margin: const EdgeInsets.all(8),
                                      // height: 200,
                                      width:
                                          MediaQuery.of(context).size.width - 32,
                                      decoration: BoxDecoration(
                                        // color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(colors: [
                                          const Color.fromARGB(255, 0, 0, 0)
                                              .withOpacity(0.8),
                                          const Color.fromARGB(255, 0, 0, 0)
                                              .withOpacity(0.2)
                                        ], begin: Alignment.bottomRight),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        newsProvider
                                            .breakingNewsArticles[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return null;
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                  ),
                ),
              )),
              const SliverToBoxAdapter(
                child: Text(
                  'TOP HEADLINES',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SliverToBoxAdapter(
                child: newsProvider.topHeadlinesArticles.isEmpty
                    ? const Center(child: Text("No articles found!!"))
                    : ListView.builder(
                        itemCount: newsProvider.topHeadlinesArticles.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 200,
                            // width: 350,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      offset: Offset(1, 2))
                                ]),
                            child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Webviewwidget(
                                            webUrl: newsProvider
                                                .topHeadlinesArticles[index]
                                                .url
                                                .toString()),
                                      ));
                                },
                                title: Text(
                                  newsProvider.topHeadlinesArticles[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color:
                                          Color.fromRGBO(0, 0, 0, 0.867)),
                                ),
                                subtitle: Text(
                                  newsProvider.topHeadlinesArticles[index]
                                          .source ??
                                      "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.black87),
                                ),
                                // trailing: SizedBox(
                                //     height: 50,
                                //     width: 50,
                                //     child: Image(
                                //       image: NetworkImage(
                                //           value.articles[index].urltoImage??""),
                                //       fit: BoxFit.cover,
                                //     )),
                              ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
