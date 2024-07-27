import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/giphy_provider.dart';
import '../views/detail_view.dart';

class GifGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GiphyProvider>(context);

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    return GridView.builder(
      itemCount: provider.gifs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final gif = provider.gifs[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailView(gif: gif),
              ),
            );
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
  