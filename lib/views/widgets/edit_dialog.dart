import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/quote.dart';

class EditDialog extends StatefulWidget {
  final Quote data;

  EditDialog({@required this.data}) : assert(data != null);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController _authorController, _contentController;
  Quote _editedQuote;

  @override
  void initState() {
    super.initState();
    this._authorController = TextEditingController();
    this._contentController = TextEditingController();
    this._editedQuote = widget.data;
    this._authorController.text = this._editedQuote.author;
    this._contentController.text = this._editedQuote.content;
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
    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: this._authorController,
              decoration: InputDecoration(labelText: 'Author'),
              autofocus: true,
            ),
            SizedBox(
              height: 4.0,
            ),
            TextField(
              controller: this._contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 3,
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('EDIT QUOTE'),
                    onPressed: () {
                      if (this._validate()) {
                        this._editedQuote.author = this._authorController.text;
                        this._editedQuote.content = this._contentController.text;
                        Navigator.of(context).pop(this._editedQuote);
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
