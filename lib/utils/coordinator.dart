import 'package:flutter/material.dart';
import '../ui/views/detail_view.dart';
import '../models/gif.dart';

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
