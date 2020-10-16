import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/quote.dart';
import 'package:flutter_boilerplate/services/quote_service.dart';
import 'package:flutter_boilerplate/views/pages/add_quote_page.dart';
import 'package:flutter_boilerplate/views/widgets/edit_dialog.dart';
import 'package:flutter_boilerplate/views/widgets/quote_card.dart';

class HomePage extends StatefulWidget {
  final String title;
  final QuoteService service;

  HomePage({this.title, @required this.service}): assert(service != null);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quote> _quotes;

  @override
  void initState() {
    super.initState();
    this._reloadData();
  }

  void _reloadData() {
    this._quotes = widget.service.getData();
  }

  Widget _buildBody() {
    return this._quotes.length > 0
        ? Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) => QuoteCard(
                key: Key('quote-$index'),
                author: this._quotes[index].author,
                content: this._quotes[index].content,
                onTap: () async {
                  Quote editedQuote = await showDialog(
                    context: context,
                    child: EditDialog(
                      data: this._quotes[index],
                    ),
                    barrierDismissible: false,
                  );
                  if (editedQuote != null) {
                    setState(() {
                      widget.service.updateQuote(editedQuote);
                    });
                  }
                },
                onDismiss: (DismissDirection direction) async {
                  bool delete = await showDialog(
                    context: context,
                    barrierDismissible: false,
                    child: AlertDialog(
                      content: Text(
                        'Are you sure you want to delete this quote?',
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          child: Text('YES'),
                          onPressed: () {
                            widget.service.deleteQuote(this._quotes.removeAt(index));
                            Navigator.of(context).pop(true);
                          },
                        ),
                        RaisedButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ],
                    ),
                  );
                  return delete;
                },
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 8.0,
              ),
              itemCount: this._quotes.length,
            ),
          )
        : Center(
            child: Text('No Data'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Quote newQuote = await Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AddQuotePage(),
          ));
          if (newQuote != null) {
            widget.service.addQuote(newQuote);
          }
        },
      ),
    );
  }
}
