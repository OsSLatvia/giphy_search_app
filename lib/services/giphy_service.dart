import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gif.dart';
import '../utils/network_checker.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class GiphyService {
  final String apiKey;
  final NetworkChecker networkChecker = NetworkChecker();

  GiphyService() : apiKey = _getApiKey();
  
  static String _getApiKey() {
    if (kIsWeb) {
      return 'JQ0EkvBKYacYqxmAXDuhvFs9oxTgamtR'; // Replace with your actual web API key
    } else if (Platform.isIOS) {
      return 'SCwgWMXf5G9afXU5cYXdpVgUPgUgS7dD'; // Replace with your actual iOS API key
    } else if (Platform.isAndroid) {
      return 'OD1lc6wX07JVfE0yOq1uOC1hGTlgnZbP'; // Replace with your actual Android API key
    } else {
      return 'FxOtJQ3bRPHXwC9Ipf9eJdFeqCSOhmNX'; // Fallback key if needed
    }
  }

  Future<List<Gif>> searchGifs(String query, int offset) async {
    // print(apiKey);
    // Check network availability before making the request
    if (!await networkChecker.isConnected()) {
      throw Exception('No internet connection');
    }

    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&offset=$offset&limit=20'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((json) => Gif.fromJson(json)).toList();
    } else {
      final data = jsonDecode(response.body);
      final errorMessage = data['meta']['msg'];
      throw Exception('Failed to load GIFs: $errorMessage');
    }
  }
}
