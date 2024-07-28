import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/gif.dart';

class DetailView extends StatelessWidget {
  final Gif gif;

  DetailView({required this.gif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: SingleChildScrollView(child: 
        Center(
            child: Column(
              children: [ 
                Text(
                  gif.title,  // Replace with the desired text
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Dimensions:" + gif.original_size_width + "x" + gif.original_size_height,  // Replace with the desired text
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 40),  // Adds space between the image and the text
                CachedNetworkImage(
                imageUrl: gif.original_size_url,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                ),
            ],)
          ),
        ),
    );
  }
}
