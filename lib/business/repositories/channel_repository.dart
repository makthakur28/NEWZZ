import 'package:news_app/data/models/news_sources_model.dart';

abstract class ChannelRepository {
  Future<List<NewsChannelsModel>> getChannelList();
}
