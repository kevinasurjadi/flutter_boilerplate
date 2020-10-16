import 'package:flutter_boilerplate/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('constructor', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Flutter Boilerplate'), findsOneWidget);
  });
}