// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card_ui/main.dart';

void main() {
  testWidgets('Membership card shows name and org details', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MembershipApp());

    // Verify the member name and organization details render.
    expect(find.text('Matthew Estilo'), findsOneWidget);
    expect(find.text('CENTRAL PHILIPPINE UNIVERSITY'), findsOneWidget);
    expect(find.text('Visit CPU on Facebook'), findsOneWidget);
  });
}
