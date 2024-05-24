class NewsModel {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String sourceName;
  final String publishedAt;
  final String author;
  final String content;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.sourceName,
    required this.publishedAt,
    required this.author,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      sourceName: json['source']['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      author: json['author'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
