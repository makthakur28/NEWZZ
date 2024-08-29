// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsArticle {
  final String title;
  final String? description;
  final String? source;
  final String? author;
  final String? url;
  final String? urltoImage;
  final String? publishedAt;
  final String? content;
  NewsArticle({
    required this.title,
    required this.description,
    required this.source,
    required this.author,
    required this.url,
    required this.urltoImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<dynamic, dynamic> json) {
    return NewsArticle(
        title: json['title'],
        description: json['description'],
        author: json['author'],
        url: json['url'],
        urltoImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content'],
        source: json['source']['name']);
  }
}
