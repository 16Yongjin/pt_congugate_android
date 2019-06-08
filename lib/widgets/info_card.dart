import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String info;

  InfoCard(this.info);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(info),
      ),
    );
  }
}
