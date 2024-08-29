import 'package:flutter/material.dart';
import 'package:news_app/presentation/providers/news_providers.dart';
import 'package:news_app/presentation/widgets/webviewwidget.dart';
import 'package:provider/provider.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({super.key});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('Inside the inistate of Channels Page');
    // debugPrint('channel loading status : ${Provider.of<NewsProviders>(context, listen: false)
    //         .isLoadingChannel}');
    Future.microtask(() =>
        Provider.of<NewsProviders>(context, listen: false).loadChannelList());
    // debugPrint('channel loading status : ${Provider.of<NewsProviders>(context, listen: false)
    //         .ChannelsList[3].url??"not found"}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NewsProviders>(builder: (context, value, child) {
        if (value.isLoadingChannel) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  // childAspectRatio:,
                  // childAspectRatio: ,
                  mainAxisExtent: 150,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: Provider.of<NewsProviders>(context, listen: false)
                  .channelsList
                  .length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Webviewwidget(
                              webUrl: Provider.of<NewsProviders>(context,
                                      listen: false)
                                  .channelsList[index]
                                  .url
                                  .toString()))),
                  child: Hero(
                    tag: 'Card${value.channelsList[index].url}',
                    child: Container(
                        // height: 200,
                        // color: Colors.amber,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                              )
                            ]),
                        child: Column(
                          children: [
                            const Card(
                              color: Colors.green,
                              child: Stack(
                                children: [
                                  Image(
                                    image:
                                        AssetImage('assets/images/NEWZZ.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  // Center(
                                  //     child: Text(
                                  //   "NewsName",
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ))
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                value.channelsList[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            ));
      }),
    );
  }
}
