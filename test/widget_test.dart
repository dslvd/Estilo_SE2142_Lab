// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card_ui/main.dart';

void main() {
  testWidgets('Playlist screen shows the app bar title and empty state', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the playlist screen renders its title and empty-state text.
    expect(find.text('My Playlist'), findsOneWidget);
    expect(find.text('No songs yet'), findsOneWidget);
  });
}
