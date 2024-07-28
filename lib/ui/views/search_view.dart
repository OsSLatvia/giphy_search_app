import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/giphy_provider.dart';
import '../widgets/gif_grid.dart';
import '../widgets/search_bar.dart' as mySearchBar;

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GiphyProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Giphy Search')),
        body: Column(
          children: [
            mySearchBar.SearchBar(), 
            Expanded(child: GifGrid()),
          ],
        ),
      ),
    );
  }
}
