import 'package:flutter_test/flutter_test.dart';

import 'package:fiveyear/main.dart';

void main() {
  testWidgets('shows the program vision and selected game library', (
    tester,
  ) async {
    await tester.pumpWidget(const BrightMindsApp());

    expect(
      find.text('Play that strengthens memory, language, focus, and confidence.'),
      findsOneWidget,
    );
    expect(find.text('Development pillars'), findsOneWidget);
    expect(find.text('Shape Matching'), findsOneWidget);
    expect(find.text('Animal Sound Recognition'), findsOneWidget);
    expect(find.text('Alphabet Match'), findsOneWidget);
  });
}
