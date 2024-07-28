import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/giphy_provider.dart';
import '../../utils/coordinator.dart'; 

class GifGrid extends StatefulWidget {
  @override
  _GifGridState createState() => _GifGridState();
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
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
      if (maxScrollExtent<250 && !provider.isLoading && provider.errorMessage == null && provider.allResultsFetched == false) {
        Provider.of<GiphyProvider>(context, listen: false).loadMoreGifs();
      }
    });

    if (provider.isLoading && provider.gifs.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    return GridView.builder(
      controller: _scrollController,
      itemCount: provider.gifs.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
    );
  }
}
