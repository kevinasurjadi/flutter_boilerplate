import 'package:flutter_boilerplate/models/quote.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty constructor', () {
    Quote quote = new Quote();
    expect(quote.id, null);
    expect(quote.author, null);
    expect(quote.content, null);
  });

  test('filled constructor', () {
    Quote quote = new Quote(id: 1, author: 'author', content: 'content');
    expect(quote.id, 1);
    expect(quote.author, 'author');
    expect(quote.content, 'content');
  });
}