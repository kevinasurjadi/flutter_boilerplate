import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/quote.dart';
import 'package:flutter_boilerplate/services/quote_service.dart';
import 'package:flutter_boilerplate/views/pages/add_quote_page.dart';
import 'package:flutter_boilerplate/views/pages/home_page.dart';
import 'package:flutter_boilerplate/views/widgets/edit_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_util/click.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {

  NavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  test('empty constructor', () {
    expect(() => HomePage(), throwsAssertionError);
  });

  test('filled constructor', () {
    String mockTitle = 'testtitle';
    QuoteService mockService = QuoteService();
    final widget = HomePage(title: mockTitle, service: mockService,);
    expect(widget.title, mockTitle);
    expect(widget.service, mockService);
  });

  testWidgets('implementation', (WidgetTester tester) async {
    String mockTitle = 'testtitle';
    QuoteService mockService = QuoteService();

    Widget buildTest(QuoteService service) {
      return MaterialApp(
        home: HomePage(title: mockTitle, service: service,),
        navigatorObservers: [mockObserver],
      );
    }

    await tester.pumpWidget(buildTest(mockService));

    // no quote
    expect(find.text(mockTitle), findsOneWidget);
    expect(find.text('No Data'), findsOneWidget);

    // any quote
    String mockAuthor = 'testauthor';
    String mockContent = 'testcontent';
    Quote mockQuote = Quote(id: 1, author: mockAuthor, content: mockContent);
    mockService.addQuote(mockQuote);
    await tester.pumpWidget(buildTest(mockService));
    expect(find.text('No Data'), findsNothing);
    expect(find.text(mockContent), findsOneWidget);

    // click quote to open edit dialog
    await clickElement(tester, find.text(mockContent));
    expect(find.byType(EditDialog), findsOneWidget);
    await clickElement(tester, find.text('CANCEL'));

    // navigation to add quote page
    await clickElement(tester, find.byType(FloatingActionButton));
    verify(mockObserver.didPush(any, any));
    expect(find.byType(AddQuotePage), findsOneWidget);
  });
}