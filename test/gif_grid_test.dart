import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../lib/ui/widgets/gif_grid.dart';
import '../lib/providers/giphy_provider.dart';
import '../lib/models/gif.dart';

class MockGiphyProvider extends ChangeNotifier implements GiphyProvider {
  @override
  List<Gif> gifs = [];
  @override
  String query = '';

  @override
  bool allResultsFetched = false;

  @override
  bool isLoading = false;

  @override
  String? errorMessage;

  int loadMoreGifsCallCount = 0;

  @override
  Future<void> loadMoreGifs() async {
    loadMoreGifsCallCount++;
    gifs.addAll(generateGifList(30));
    // allResultsFetched=true;
    notifyListeners(); 
  }

  @override
  Future<void> searchGifs(String query) async {}
}
List<Gif> generateGifList(int count) {
  return List.generate(count, (index) => Gif(
    id: '$index',
    url: 'https://via.placeholder.com/150',
    original_size_url: 'https://via.placeholder.com/600',
    original_size_height: '600',
    original_size_width: '600',
    title: 'Test Gif $index',
    username: 'test_user',
    import_datetime: '2024-07-29 12:00:00',
  ));
}
Widget createWidgetUnderTest(mockGiphyProvider) {
  return ChangeNotifierProvider<GiphyProvider>(
    create: (context) => mockGiphyProvider,
    child: MaterialApp(
      home: Scaffold(
        body: GifGrid(),
      ),
    ),
  );
}
void main() {


  testWidgets('GifGrid shows CircularProgressIndicator when loading, and last gif list is empty', (WidgetTester tester) async {
    final mockGiphyProvider = MockGiphyProvider();
    mockGiphyProvider.isLoading=true ;
    mockGiphyProvider.gifs=[];
    await tester.pumpWidget(createWidgetUnderTest(mockGiphyProvider));

    expect(find.byType(CircularProgressIndicator), findsExactly(1));
  });
    testWidgets('GifGrid shows "No gifs found" message when loading ends with empty list', (WidgetTester tester) async {
    final mockGiphyProvider = MockGiphyProvider();
    mockGiphyProvider.isLoading=false ;
    mockGiphyProvider.gifs=[];
 
    await tester.pumpWidget(createWidgetUnderTest(mockGiphyProvider));

    expect(find.text('No gifs found'), findsExactly(1));
  });

  testWidgets('GifGrid shows error message when there is an error', (WidgetTester tester) async {
    final mockGiphyProvider = MockGiphyProvider()..errorMessage = 'An error occurred';

    await tester.pumpWidget(createWidgetUnderTest(mockGiphyProvider));

    expect(find.text('An error occurred'), findsOneWidget);
  });

  testWidgets('GifGrid shows gifs when data is available', (WidgetTester tester) async {
    final mockGiphyProvider = MockGiphyProvider();

    mockGiphyProvider.gifs=generateGifList(2);
    mockGiphyProvider.allResultsFetched=true;
    await tester.pumpWidget(createWidgetUnderTest(mockGiphyProvider));

    expect(find.byType(CachedNetworkImage), findsExactly(mockGiphyProvider.gifs.length));
  });

  testWidgets('GifGrid calls loadMoreGifs when scrolled to the bottom', (WidgetTester tester) async {
    final mockGiphyProvider = MockGiphyProvider();
    mockGiphyProvider.gifs=generateGifList(40);
    await tester.pumpWidget(createWidgetUnderTest(mockGiphyProvider));
    final scrollController = tester.widget<Scrollable>(find.byType(Scrollable)).controller!;

    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    await tester.pump();

    expect(mockGiphyProvider.loadMoreGifsCallCount, greaterThan(0));
  });
}
