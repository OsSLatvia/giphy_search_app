class Gif {
  final String id;
  final String url;
  final String title;

  Gif({required this.id, required this.url, required this.title});

  factory Gif.fromJson(Map<String, dynamic> json) {
    return Gif(
      id: json['id'],
      url: json['images']['fixed_height']['url'],
      title: json['title'],
    );
  }
}
