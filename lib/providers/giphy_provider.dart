import 'dart:async';
import 'package:flutter/material.dart';
import 'package:giphy_search_app/models/gif.dart';
import 'package:giphy_search_app/services/giphy_service.dart';
import 'package:giphy_search_app/utils/network_checker.dart';

class GiphyProvider with ChangeNotifier {
  final GiphyService _giphyService;
  final NetworkChecker _networkChecker = NetworkChecker();
  StreamSubscription<bool>? _networkSubscription;

  List<Gif> _gifs = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _query = "";
  bool _allResultsFetched = false;

  GiphyProvider({GiphyService? giphyService}) : _giphyService = giphyService ?? GiphyService() {
    _networkSubscription = _networkChecker.onConnectivityChanged.listen((connected) {
      if (!connected) {
        _errorMessage = "No internet connection";
        notifyListeners();
      } else if (_errorMessage == "No internet connection" && _query.isNotEmpty) {
        _errorMessage = null;
        notifyListeners(); 
        searchGifs(_query);
      }
    });
  }

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
    if (query.isNotEmpty) {
      _isLoading = true;
      notifyListeners();
      this.query = query;

      final connected = await _networkChecker.isConnected();
      if (!connected) {
        _errorMessage = "No internet connection";
        _isLoading = false;
        notifyListeners();
        return;
      }

      try {
        _gifs = await _giphyService.searchGifs(query, 0);
        _errorMessage = null;
        _allResultsFetched = _gifs.length < 20;
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadMoreGifs() async {
    if (_query.isNotEmpty && !_allResultsFetched && !_isLoading) {
      _isLoading = true;
      notifyListeners();

      final connected = await _networkChecker.isConnected();
      if (!connected) {
        _errorMessage = "No internet connection";
        _isLoading = false;
        notifyListeners();
        return;
      }

      try {
        final offset = _gifs.length;
        final moreGifs = await _giphyService.searchGifs(_query, offset);
        _gifs.addAll(moreGifs);
        _allResultsFetched = moreGifs.length < 20;
        _errorMessage = null;
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _networkSubscription?.cancel();
    super.dispose();
  }
}
