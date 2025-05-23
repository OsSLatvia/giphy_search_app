import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:giphy_search_app/models/gif.dart';
import 'package:giphy_search_app/ui/views/detail_view.dart';

List<Gif> generateGifList(int count) {
  return List.generate(count, (index) => Gif(
    id: '$index',
    url: 'https://via.placeholder.com/150',
    originalSizeUrl: 'https://via.placeholder.com/600',
    originalSizeHeight: '600',
    originalSizeWidth: '600',
    title: 'Test Gif $index',
    username: 'test_user',
    importDatetime: '2024-07-29 12:00:00',
  ));
}
    final gif = generateGifList(1)[0];

void main() {
  testWidgets('DetailView displays the Gif details correctly', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(MaterialApp(home: DetailView(gif: gif)));

    expect(find.text(gif.title), findsOneWidget);
    
    // Check if the dimensions text is displayed
    expect(find.text('Dimensions:${gif.originalSizeWidth}x${gif.originalSizeHeight}'), findsOneWidget);
    
    // Check if the CachedNetworkImage is displayed
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    
  });
}
