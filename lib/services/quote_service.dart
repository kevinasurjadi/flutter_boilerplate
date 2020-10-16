import 'package:flutter_boilerplate/models/quote.dart';

class QuoteService {
  List<Quote> _quotes;

  QuoteService() {
    this._quotes = List<Quote>();
  }

  List<Quote> getData() {
    return this._quotes;
  }

  void addQuote(Quote newQuote) {
    int lastId = 1;
    if (this._quotes.length > 0) {
      lastId = this._quotes.last.id;
    }
    this._quotes.add(newQuote..id = lastId + 1);
  }

  void updateQuote(Quote quote) {
    int index = this._quotes.indexWhere((searchQuote) => searchQuote.id == quote.id);
    if (index > -1) {
      this._quotes.replaceRange(index, index + 1, [quote]);
    }
  }

  void deleteQuote(Quote quote) {
    int index = this._quotes.indexWhere((searchQuote) => searchQuote.id == quote.id);
    if (index > -1) {
      this._quotes.removeAt(index);
    }
  }
}