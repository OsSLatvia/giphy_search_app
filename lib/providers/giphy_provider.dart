import 'package:flutter/material.dart';
import '../models/gif.dart';
import '../services/giphy_service.dart';

class GiphyProvider with ChangeNotifier {
  final GiphyService _giphyService = GiphyService();
  List<Gif> _gifs = [];
  bool _isLoading = false;
  String? _errorMessage;
  String query = "";
  bool _allResultsFetched=false;
  // int _offset = 0; 

  List<Gif> get gifs => _gifs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get allResultsFetched => _allResultsFetched;

  Future<void> searchGifs(String query) async {
    if (query.isNotEmpty){
      _isLoading = true;
      notifyListeners();
      this.query = query;
      // _offset = 0; // Reset offset for new search

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

  Future<void> loadMoreGifs() async {
    if (query.isNotEmpty && !_allResultsFetched){
      if (_isLoading) return;
      _isLoading = true;
      notifyListeners();
      // _offset += 20; 

      try {
        final offset = _gifs.length;
        final moreGifs = await _giphyService.searchGifs(query, offset);
        _gifs.addAll(moreGifs);
        if (moreGifs.length<20){
          _allResultsFetched = true;
        }
        _errorMessage = null;
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
