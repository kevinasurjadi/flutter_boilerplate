import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/quote_service.dart';
import 'package:flutter_boilerplate/views/pages/home_page.dart';

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  final String _title = 'Flutter Boilerplate';
  final QuoteService _service = QuoteService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this._title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: this._title,
        service: this._service,
      ),
    );
  }
}
