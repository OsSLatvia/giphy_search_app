import 'package:flutter/material.dart';
import 'ui/views/search_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchView(),
    );
  }
}
