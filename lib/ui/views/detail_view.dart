import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/gif.dart';

class DetailView extends StatelessWidget {
  final Gif gif;

  DetailView({required this.gif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gif.title)),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: gif.url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
