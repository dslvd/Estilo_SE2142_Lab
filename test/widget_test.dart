// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card_ui/main.dart';

void main() {
  testWidgets('Playlist screen lists all songs and navigates to Now Playing', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the playlist screen renders its title and every song.
    expect(find.text('My Playlist'), findsOneWidget);
    expect(find.text('Sunset Drive'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));

    // Tapping a song navigates to Now Playing with that song's title.
    await tester.tap(find.text('Sunset Drive'));
    await tester.pumpAndSettle();
    expect(find.text('Playing: Sunset Drive'), findsOneWidget);

    // The back button returns to the playlist.
    await tester.tap(find.text('Stop and Go Back'));
    await tester.pumpAndSettle();
    expect(find.text('My Playlist'), findsOneWidget);
  });
}
