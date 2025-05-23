class Gif {
  final String id;
  final String url;
  final String originalSizeUrl;
  final String originalSizeHeight;
  final String originalSizeWidth;
  final String title;
  final String username;
  final String importDatetime;

  Gif({
    required this.id,
    required this.url,
    required this.originalSizeUrl,
    required this.originalSizeHeight,
    required this.originalSizeWidth,
    required this.title,
    required this.username,
    required this.importDatetime,
  });

  factory Gif.fromJson(Map<String, dynamic> json) {
    return Gif(
      id: json['id'],
      url: json['images']['fixed_height']['url'],
      originalSizeUrl: json['images']['original']['url'],
      originalSizeHeight: json['images']['original']['height'],
      originalSizeWidth: json['images']['original']['width'],
      title: json['title'],
      username: json['username'],
      importDatetime: json['import_datetime'],
    );
  }
}