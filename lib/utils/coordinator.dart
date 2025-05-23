import 'package:flutter/material.dart';
import 'package:giphy_search_app/ui/views/detail_view.dart';
import 'package:giphy_search_app/models/gif.dart';

class Coordinator {
  static void navigateToDetail(BuildContext context, Gif gif) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailView(gif: gif),
      ),
    );
  }
}
