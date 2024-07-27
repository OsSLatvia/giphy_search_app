import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gif.dart';

class GiphyService {
  final String apiKey = 'JQ0EkvBKYacYqxmAXDuhvFs9oxTgamtR';

  Future<List<Gif>> searchGifs(String query, int offset) async {
    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&offset=$offset&limit=20'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((json) => Gif.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load GIFs');
    }
  }
}
