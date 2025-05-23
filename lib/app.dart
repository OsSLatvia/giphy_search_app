import 'package:flutter/material.dart';
import 'package:giphy_search_app/ui/views/search_view.dart';
import 'package:giphy_search_app/ui/widgets/network_status_banner.dart'; // Your banner widget import

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        // Wraps all routes/screens with the NetworkStatusBanner
        return Stack(
          children: [
            if (child != null) child,
            const Positioned(
              top: 40, // or whatever position you want
              right: 20,
              child: NetworkStatusBanner(),
            ),
          ],
        );
      },
      home: const SearchView(),
    );
  }
}
