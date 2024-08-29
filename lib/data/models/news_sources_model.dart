// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsChannelsModel {
  String id;
  String name;
  String? url;
  String? description;
  NewsChannelsModel({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
  });

  factory NewsChannelsModel.fromJson(Map<String, dynamic> json) {
    return NewsChannelsModel(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        description: json['description']);
  }
}
