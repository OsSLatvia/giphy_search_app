import 'package:flutter/material.dart';
import '../models/gif.dart';
import '../services/giphy_service.dart';

class GiphyProvider with ChangeNotifier {
  final GiphyService _giphyService = GiphyService();
  List<Gif> _gifs = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Gif> get gifs => _gifs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> searchGifs(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _gifs = await _giphyService.searchGifs(query, 0);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
