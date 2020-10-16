import 'package:flutter_boilerplate/models/quote.dart';
import 'package:flutter_boilerplate/services/quote_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('constructor', () {
    QuoteService quoteService = QuoteService();
    expect(quoteService.getData(), []);
  });

  test('addQuote', () {
    Quote mock = Quote(id: 0, author: 'testauthor', content: 'testcontent');
    QuoteService quoteService = QuoteService();
    expect(quoteService.getData().length, 0);
    quoteService.addQuote(mock);
    expect(quoteService.getData().length, 1);
    expect(quoteService.getData()[0], mock);
  });

  test('updateQuote', () {
    Quote mock = Quote(id: 0, author: 'testauthor', content: 'testcontent');
    QuoteService quoteService = QuoteService();
    quoteService.addQuote(mock);
    expect(quoteService.getData().length, 1);
    Quote mockUpdate = mock
      ..author = 'updatetestauthor'
      ..content = 'updatetestcontent';
    quoteService.updateQuote(mockUpdate);
    expect(quoteService.getData().length, 1);
    expect(quoteService.getData()[0], mockUpdate);
  });

  test('deleteQuote', () {
    Quote mock = Quote(id: 0, author: 'testauthor', content: 'testcontent');
    QuoteService quoteService = QuoteService();
    quoteService.addQuote(mock);
    expect(quoteService.getData().length, 1);
    quoteService.deleteQuote(mock);
    expect(quoteService.getData().length, 0);
  });
}