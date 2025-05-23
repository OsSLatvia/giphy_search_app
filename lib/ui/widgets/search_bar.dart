import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:giphy_search_app/providers/giphy_provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State <SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      Provider.of<GiphyProvider>(context, listen: false).searchGifs(query);
    });
  } //debuncer ensures API request is made olny after user stops writing (500 miliseconds)

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: _onSearchChanged,
        decoration: const InputDecoration(
          labelText: 'Search GIFs',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
