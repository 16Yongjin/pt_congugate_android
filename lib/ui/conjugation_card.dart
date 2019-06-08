import 'package:flutter/material.dart';

class RoundCard extends StatelessWidget {
  final Widget child;

  RoundCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: child,
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  final Color color;

  CardHeader({this.title, this.color = Colors.lightBlue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style:
              TextStyle(fontFamily: 'Godo', color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String subject;
  final String verb;

  const CardContent({this.subject, this.verb});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              subject,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(verb, style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
