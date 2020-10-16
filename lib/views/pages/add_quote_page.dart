import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/quote.dart';

class AddQuotePage extends StatefulWidget {
  @override
  _AddQuotePageState createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  TextEditingController _authorController, _contentController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this._authorController = TextEditingController();
    this._contentController = TextEditingController();
  }


  @override
  void dispose() {
    this._authorController.dispose();
    this._contentController.dispose();
    super.dispose();
  }

  bool _validate() {
    if (this._authorController == null || this._contentController == null) {
      return false;
    } else {
      return this._authorController.text.isNotEmpty &&
          this._contentController.text.isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add New Quote'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: <Widget>[
                TextField(
                  key: Key('add-quote-author-field'),
                  controller: this._authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                  autofocus: true,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  key: Key('add-quote-content-field'),
                  controller: this._contentController,
                  decoration: InputDecoration(labelText: 'Content'),
                  maxLines: 5,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text('ADD QUOTE'),
                        onPressed: () {
                          if (this._validate()) {
                            Navigator.of(context).pop(Quote(
                              author: this._authorController.text,
                              content: this._contentController.text,
                            ));
                          } else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Fields must not be empty.'),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
