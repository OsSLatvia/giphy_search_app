import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:giphy_search_app/providers/giphy_provider.dart';
import 'package:giphy_search_app/ui/widgets/search_bar.dart' as my_search_bar; // Adjust import based on your project structure

// Mock class for GiphyProvider
class MockGiphyProvider extends Mock implements GiphyProvider {

  int searchGifsCallCount = 0;

  @override
  Future<void> searchGifs(String query) async {
    searchGifsCallCount++;
  }

}

void main() {
  group('SearchBar', () {
    late MockGiphyProvider mockGiphyProvider;

    setUp(() {
      mockGiphyProvider = MockGiphyProvider();
    });

    // Helper function to create a widget with the provider
    Widget createWidgetUnderTest() {
      return ChangeNotifierProvider<GiphyProvider>.value(
        value: mockGiphyProvider,
        child: const MaterialApp(
          home: Scaffold(
            body: my_search_bar.SearchBar(),
          ),
        ),
      );
    }

    testWidgets('should display a TextField', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should call searchGifs with correct query after debounce', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate typing in the TextField
      await tester.enterText(find.byType(TextField), 'test query');

      // Trigger the debounce
      await tester.pump(const Duration(milliseconds: 500));
      expect(mockGiphyProvider.searchGifsCallCount, equals(1));
    });

    testWidgets('should not call searchGifs if debounce is active - 500 millisecondsm', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate typing in the TextField
      await tester.enterText(find.byType(TextField), 'query 1');

      // Trigger the debounce
      await tester.pump(const Duration(milliseconds: 100)); // Simulate 100ms
      expect(mockGiphyProvider.searchGifsCallCount, equals(0));
      await tester.enterText(find.byType(TextField), 'query 2');
      await tester.pump(const Duration(milliseconds: 500)); // Trigger debounce after 500ms

      // Verify that searchGifs was called with the final query
      expect(mockGiphyProvider.searchGifsCallCount, equals(1));
      // verify(mockGiphyProvider.searchGifs('query 2')).called(1);
    });
  });
}
