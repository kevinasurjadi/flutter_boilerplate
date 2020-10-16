
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/quote_service.dart';
import 'package:flutter_boilerplate/views/pages/add_quote_page.dart';
import 'package:flutter_boilerplate/views/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_util/click.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  NavigatorObserver mockObserver = MockNavigatorObserver();

  testWidgets('constructor', (WidgetTester tester) async {
    final widget = MaterialApp(
      home: AddQuotePage(),
    );
    await tester.pumpWidget(widget);
    expect(find.byType(AddQuotePage), findsOneWidget);
  });

  testWidgets('implementation', (WidgetTester tester) async {
    final widget = MaterialApp(
      home: HomePage(title: 'testtitle', service: QuoteService(),),
      navigatorObservers: [mockObserver],
    );
    await tester.pumpWidget(widget);
    await clickElement(tester, find.byType(FloatingActionButton));

    expect(find.byType(AddQuotePage), findsOneWidget);
    expect(find.text('Add New Quote'), findsOneWidget);

    // empty form
    expect(find.text('Fields must not be empty.'), findsNothing);
    await clickElement(tester, find.text('ADD QUOTE'));
    expect(find.text('Fields must not be empty.'), findsOneWidget);

    // fill author
    await tester.enterText(find.byKey(Key('add-quote-author-field')), 'testauthor');
    await clickElement(tester, find.text('ADD QUOTE'));
    expect(find.text('Fields must not be empty.'), findsOneWidget);

    // fill content
    await tester.enterText(find.byKey(Key('add-quote-content-field')), 'testcontent');
    await clickElement(tester, find.text('ADD QUOTE'));

    verify(mockObserver.didPop(any, any));

    expect(find.byType(AddQuotePage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}