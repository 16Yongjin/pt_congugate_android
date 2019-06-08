import 'package:flutter/material.dart';
import 'package:pt_conjugate/models/conjugated_verb.dart';
import 'package:pt_conjugate/ui/conjugation_card.dart';

class ConjugationCardExtra extends StatelessWidget {
  final String koType;
  final List<Conjugations> conjugations;

  ConjugationCardExtra({this.koType, this.conjugations});

  @override
  Widget build(BuildContext context) {
    return RoundCard(
      child: Column(
        children: <Widget>[
          CardHeader(title: koType),
          ...conjugations.map((conjucation) => ListTile(
              title: Text(conjucation.value, style: TextStyle(fontSize: 20))))
        ],
      ),
    );
  }
}
