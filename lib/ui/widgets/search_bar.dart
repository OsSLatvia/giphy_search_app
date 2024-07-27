import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/giphy_provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GiphyProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          if (query.length > 2) {
            provider.searchGifs(query);
          }
        },
        decoration: InputDecoration(
          labelText: 'Search GIFs',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
