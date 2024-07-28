class Gif {
  final String id;
  final String url;
  final String original_size_url;
  final String original_size_height;
  final String original_size_width;
  final String title;
  final String username;
  final String import_datetime;

  Gif({
    required this.id,
    required this.url,
    required this.original_size_url,
    required this.original_size_height,
    required this.original_size_width,
    required this.title,
    required this.username,
    required this.import_datetime,
  });

  factory Gif.fromJson(Map<String, dynamic> json) {
    return Gif(
      id: json['id'],
      url: json['images']['fixed_height']['url'],
      original_size_url: json['images']['original']['url'],
      original_size_height: json['images']['original']['height'],
      original_size_width: json['images']['original']['width'],
      title: json['title'],
      username: json['username'],
      import_datetime: json['import_datetime'],
    );
  }
}