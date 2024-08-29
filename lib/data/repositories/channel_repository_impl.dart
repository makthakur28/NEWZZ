// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_app/business/repositories/channel_repository.dart';
import 'package:news_app/data/models/news_sources_model.dart';
import 'package:news_app/data/sources/remote/api_service.dart';

class ChannelRepositoryImpl extends ChannelRepository {
  ApiService apiService;
  ChannelRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<List<NewsChannelsModel>> getChannelList() async{
    return apiService.fetchChannelList();
  }
}
