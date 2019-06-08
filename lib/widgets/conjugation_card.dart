import 'package:flutter/material.dart';
import 'package:pt_conjugate/models/conjugated_verb.dart';
import 'package:pt_conjugate/ui/conjugation_card.dart';

class ConjugationCard extends StatelessWidget {
  final String koType;
  final List<Conjugations> conjugations;

  ConjugationCard({this.koType, this.conjugations});

  @override
  Widget build(BuildContext context) {
    return RoundCard(
      child: Column(
        children: <Widget>[
          CardHeader(title: koType),
          ...conjugations.map((conjucation) => CardContent(
                subject: ConjugatedVerbViewModel.getSubject(conjucation.sort),
                verb: conjucation.value,
              )),
        ],
      ),
    );
  }
}
