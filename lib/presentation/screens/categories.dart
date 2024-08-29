import 'package:flutter/material.dart';
import 'package:news_app/presentation/providers/news_providers.dart';
import 'package:news_app/presentation/widgets/webviewwidget.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // List<String> category = [];
  Color btnColor = Colors.transparent;
  final SearchController controller = SearchController();

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<NewsProviders>(context, listen: false);
    Future.microtask(() => provider.loadCategoryNews(provider.categories[0]));
  }

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProviders>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(16),
      // color: Colors.amber,
      child: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
            child: SearchBar(
          controller: controller,
          leading: const Icon(Icons.search),
          hintText: 'Search',
          onSubmitted: (value) => newsProvider.loadCategoryNews(value),
          trailing: [
            IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(Icons.cancel))
          ],
          // // autoFocus: false,
          // focusNode: FocusNode(canRequestFocus: true),
          // // onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        )),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            child: ListView.builder(
              itemCount: Provider.of<NewsProviders>(context, listen: true)
                  .categories
                  .length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // var btnprovider =
                //     Provider.of<NewsProviders>(context, listen: true);
                return TextButton(
                  onPressed: () {
                    controller.clear();
                    newsProvider
                        .loadCategoryNews(newsProvider.categories[index]);
                    // btnColor =const  Color.fromARGB(255, 138, 202, 255);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        newsProvider
                                .categoryMap[newsProvider.categories[index]]!
                            ? const Color.fromRGBO(157, 189, 255,1)
                            : Colors.transparent,
                      ),
                      shape: const WidgetStatePropertyAll(
                          ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))))),
                  child: Text(
                    Provider.of<NewsProviders>(context, listen: true)
                        .categories[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ),
        Consumer<NewsProviders>(builder: (context, newsProvider, child) {
          if (newsProvider.isLoadingCategory) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (newsProvider.categorySpecificArticles.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("No categories found"),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Webviewwidget(
                              webUrl: newsProvider
                                  .categorySpecificArticles[index].url
                                  .toString()),
                        ));
                  },
                  child: Hero(
                    tag: 'Card${newsProvider.categorySpecificArticles[index].url}',
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(157, 189, 255,1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black26)],
                          image: DecorationImage(
                              image: (newsProvider.categorySpecificArticles[index].urltoImage!=null)?NetworkImage(newsProvider
                                      .categorySpecificArticles[index]
                                      .urltoImage!
                              ):const AssetImage('assets/images/NEWZZ.png'),
                              fit: BoxFit.cover)),
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.8),
                              const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.2)
                            ], begin: Alignment.bottomRight),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                newsProvider
                                    .categorySpecificArticles[index].title,
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
              },
              childCount: newsProvider.categorySpecificArticles.length,
            ),
          );
        })
      ]),
    );
  }
}
