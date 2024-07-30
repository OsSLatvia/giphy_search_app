import 'package:flutter/material.dart';
import '../models/gif.dart';
import '../services/giphy_service.dart';

class GiphyProvider with ChangeNotifier {
  final GiphyService _giphyService;
  List<Gif> _gifs = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _query = "";
  bool _allResultsFetched=false;
  // int _offset = 0; 

  GiphyProvider({GiphyService? giphyService}) : _giphyService = giphyService ?? GiphyService();
  String get query => _query;
  set query(String value) {
    _query = value;
    notifyListeners();
  }
  List<Gif> get gifs => _gifs;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  String? get errorMessage => _errorMessage;
  bool get allResultsFetched => _allResultsFetched;
  set allResultsFetched(bool value) {
    _allResultsFetched = value;
    notifyListeners();
  }

  Future<void> searchGifs(String query) async {
    if (query.isNotEmpty){
      _isLoading = true;
      notifyListeners();
      this.query = query;
      // _offset = 0; // Reset offset for new search

      try {
        _gifs = await _giphyService.searchGifs(query, 0);
        _errorMessage = null;
        if (_gifs.length<20){
          _allResultsFetched=true;
        }
        else _allResultsFetched=false;
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
