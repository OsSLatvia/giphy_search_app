import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:giphy_search_app/providers/giphy_provider.dart';
import 'package:giphy_search_app/utils/coordinator.dart'; 

class GifGrid extends StatefulWidget {
  const GifGrid({super.key});

  @override
  State <GifGrid> createState() => _GifGridState();
}

class _GifGridState extends State<GifGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels != 0;
      if (isBottom) {
        Provider.of<GiphyProvider>(context, listen: false).loadMoreGifs();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GiphyProvider>(context);

  // Trigger an initial load if the list isn't filling the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        if (maxScrollExtent < 250 && !provider.isLoading && provider.errorMessage == null && !provider.allResultsFetched) {
          Provider.of<GiphyProvider>(context, listen: false).loadMoreGifs();
        }
      }
    });
    if (provider.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.clearSnackBars();
        scaffold.showSnackBar(
          SnackBar(content: Text(provider.errorMessage!)),
        );
      });
    }
  //loadingIndicator is shown  olny if last gif list is empty, while loading if last list is not empty, keep showing last gifs.
    if (provider.isLoading && provider.gifs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

  //if after loading list is still empty, no gifs have been found 
    if (!provider.isLoading && provider.gifs.isEmpty) {
      return const Center(child: Text('No gifs found'));
    }

    return GridView.builder(
      controller: _scrollController,
      itemCount: provider.gifs.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.0,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) {
        final gif = provider.gifs[index];
        return GestureDetector(
          onTap: () {
            Coordinator.navigateToDetail(context, gif); // Use Coordinator for navigation
          },
          child: CachedNetworkImage(
            imageUrl: gif.url,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}
