import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giphy_search_app/providers/giphy_provider.dart';
import 'package:giphy_search_app/ui/widgets/gif_grid.dart';
import 'package:giphy_search_app/ui/widgets/search_bar.dart' as my_search_bar;

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GiphyProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Giphy Search')),
        body: const Column(
          children: [
            my_search_bar.SearchBar(), 
            Expanded(child: GifGrid()),
          ],
        ),
      ),
    );
  }
}
