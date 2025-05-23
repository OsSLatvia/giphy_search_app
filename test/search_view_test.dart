import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:giphy_search_app/ui/views/search_view.dart'; // Adjust the import based on your project structure
import 'package:giphy_search_app/ui/widgets/gif_grid.dart';
import 'package:giphy_search_app/ui/widgets/search_bar.dart' as my_search_bar;
import 'package:giphy_search_app/providers/giphy_provider.dart';

void main() {
  testWidgets('SearchView displays SearchBar and GifGrid', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => GiphyProvider(),
          child: const SearchView(),
        ),
      ),
    );

    // Assert
    // Verify that SearchBar is displayed
    expect(find.byWidgetPredicate((widget) => widget is my_search_bar.SearchBar), findsOneWidget);

    // Verify that GifGrid is displayed
    expect(find.byType(GifGrid), findsOneWidget);

    // Verify that the AppBar title is displayed
    expect(find.text('Giphy Search'), findsOneWidget);
  });

  testWidgets('SearchView initializes GiphyProvider', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => GiphyProvider(),
          child: const SearchView(),
        ),
      ),
    );

    // Assert
    // Verify that the GiphyProvider is correctly provided
    expect(
      Provider.of<GiphyProvider>(tester.element(find.byType(SearchView)), listen: false),
      isA<GiphyProvider>(),
    );
  });
}
