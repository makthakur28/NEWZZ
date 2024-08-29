import 'package:news_app/business/repositories/channel_repository.dart';
import 'package:news_app/data/models/news_sources_model.dart';

class GetChannelsList {
  ChannelRepository repository;
  GetChannelsList({required this.repository});

  Future<List<NewsChannelsModel>> execute() async {
    return repository.getChannelList();
  }
}
