import 'package:flutter/material.dart';
import 'package:pt_conjugate/models/conjugated_verb.dart';
import 'package:pt_conjugate/ui/conjugation_card.dart';

class ConjugationCardPP extends StatelessWidget {
  final String koType;
  final List<Conjugations> conjugations;

  ConjugationCardPP({this.koType, this.conjugations});

  @override
  Widget build(BuildContext context) {
    return RoundCard(
      child: Column(
        children: <Widget>[
          CardHeader(title: koType),
          ...conjugations.map((conjucation) => CardContent(
                subject: ConjugatedVerbViewModel.ppSubjects[conjucation.sort],
                verb: conjucation.value,
              )),
        ],
      ),
    );
  }
}
