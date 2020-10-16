import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/quote.dart';
import 'package:flutter_boilerplate/views/widgets/edit_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util/click.dart';

void main() {
  test('empty constructor', () {
    expect(() => EditDialog(), throwsAssertionError);
  });

  test('filled constructor', () {
    Quote mock = Quote();
    final widget = EditDialog(data: mock);
    expect(widget.data, mock);
  });

  testWidgets('implementation', (WidgetTester tester) async {
    Quote mock = Quote(id: 1, author: 'testauthor', content: 'testcontent');
    final widget = MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return RaisedButton(
          child: Text('Click Me!'),
          onPressed: () {
            showDialog(context: context, child: EditDialog(data: mock));
          },
        );
      }),
    );

    await tester.pumpWidget(widget);

    // open dialog
    await clickElement(tester, find.text('Click Me!'));

    expect(find.text(mock.author), findsOneWidget);
    expect(find.text(mock.content), findsOneWidget);

    // close dialog by clicking `cancel` button
    await clickElement(tester, find.text('CANCEL'));
    expect(find.text(mock.author), findsNothing);

    // open dialog
    await clickElement(tester, find.text('Click Me!'));

    // close dialog by clicking `edit quote` button
    await clickElement(tester, find.text('EDIT QUOTE'));
    expect(find.text(mock.author), findsNothing);
  });
}
