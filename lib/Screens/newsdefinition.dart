class ClientNewsItem {
  final String title;
  final String? author;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final Map<String, dynamic> source;
  final String? content;
  final String? description;

  // Added properties
  final String? imageAsset;
  final String? fullArticleUrl;
  final String? body;

  ClientNewsItem({
    required this.title,
    this.author,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.source,
    this.content,
    this.description,
    this.imageAsset,
    this.fullArticleUrl,
    this.body,
  });

  factory ClientNewsItem.fromJson(Map<String, dynamic> json) {
    return ClientNewsItem(
      title: json['title'],
      author: json['author'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      source: json['source'],
      content: json['content'],
      description: json['description'],
      // Map these properties from JSON if available
      imageAsset: json['urlToImage'], // Assuming 'urlToImage' is the field for image assets
      fullArticleUrl: json['url'], // Assuming 'url' is used for full article URLs
      body: json['content'], // Assuming 'content' is used for body
    );
  }
}
