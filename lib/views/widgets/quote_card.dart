import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final Key key;
  final String author;
  final String content;
  final Function onTap;
  final Function onDismiss;

  QuoteCard({
    @required this.key,
    @required this.author,
    @required this.content,
    @required this.onTap,
    @required this.onDismiss,
  })  : assert(key != null),
        assert(author != null),
        assert(content != null),
        assert(onTap != null),
        assert(onDismiss != null);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: this.key,
      confirmDismiss: onDismiss,
      child: InkWell(
        onTap: this.onTap,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.content,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "- ${this.author}",
                      style: Theme.of(context).textTheme.subtitle,
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
