import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:giphy_search_app/models/gif.dart';

class DetailView extends StatelessWidget {
  final Gif gif;

  const DetailView({super.key, required this.gif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: SingleChildScrollView(child: 
        Center(
            child: Column(
              children: [ 
                Text(
                  gif.title,  // Replace with the desired text
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  "Dimensions:${gif.originalSizeWidth}x${gif.originalSizeHeight}",  // Replace with the desired text
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 40),  // Adds space between the image and the text
                CachedNetworkImage(
                imageUrl: gif.originalSizeUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
            ],)
          ),
        ),
    );
  }
}
