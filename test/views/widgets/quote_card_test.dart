import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/views/widgets/quote_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util/click.dart';
import '../../test_util/dismiss.dart';

void main() {
  String mockAuthor = 'testauthor';
  String mockContent = 'testcontent';

  test('empty constructor', () {
    expect(() => QuoteCard(), throwsAssertionError);
  });

  test('filled constructor', () {
    Key mockKey = Key('testkey');
    mockOnTap() {}
    mockOnDismiss() {}

    final widget = QuoteCard(
      key: mockKey,
      author: mockAuthor,
      content: mockContent,
      onTap: mockOnTap,
      onDismiss: mockOnDismiss,
    );
    expect(widget.key, mockKey);
    expect(widget.author, mockAuthor);
    expect(widget.content, mockContent);
    expect(widget.onTap, mockOnTap);
    expect(widget.onDismiss, mockOnDismiss);
  });

  testWidgets('implementation', (WidgetTester tester) async {
    List<String> logs = [];
    mockOnTap() {
      logs.add('tap');
    }

    mockOnDismissSuccess(DismissDirection direction) {
      return Future<bool>.value(true);
    }
    mockOnDismissFail(DismissDirection direction) {
      return Future<bool>.value(false);
    }

    Widget buildTest(Future<bool> onDismiss(DismissDirection direction)) {
      return MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              child: ListView(
                children: List.generate(
                  3,
                      (int index) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          QuoteCard(
                            key: Key('testkey-$index'),
                            author: mockAuthor,
                            content: "${index + 1}. $mockContent",
                            onTap: mockOnTap,
                            onDismiss: onDismiss,
                          )),
                ),
              ),
            ),
          ),
        ),
      );
    }
    await tester.pumpWidget(buildTest(mockOnDismissFail));

    expect(find.byType(QuoteCard), findsNWidgets(3));

    Finder firstElement = find.text('1. $mockContent');

    // on tap
    await clickElement(tester, firstElement);
    expect(logs.first, 'tap');

    // on dismiss fail
    await dismissItem(tester, firstElement, gestureDirection: AxisDirection.right, mechanism: flingElement);
    expect(firstElement, findsOneWidget);

    // on dismiss success
    await tester.pumpWidget(buildTest(mockOnDismissSuccess));
    await dismissItem(tester, firstElement, gestureDirection: AxisDirection.right, mechanism: flingElement);
    expect(firstElement, findsNothing);
  });
}
