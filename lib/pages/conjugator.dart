import 'package:flutter/material.dart';
import 'package:pt_conjugate/models/conjugated_verb.dart';
import 'package:pt_conjugate/widgets/conjugation_card.dart';
import 'package:pt_conjugate/widgets/conjugation_card_extra.dart';
import 'package:pt_conjugate/widgets/conjugation_card_pp.dart';
import 'package:pt_conjugate/widgets/info_card.dart';
import 'package:pt_conjugate/widgets/search_bar_mini.dart';

class ConjugatorPage extends StatefulWidget {
  final String verb;
  ConjugatorPage(this.verb);

  @override
  State<StatefulWidget> createState() => _ConjugatorPageState();
}

class _ConjugatorPageState extends State<ConjugatorPage> {
  ConjugatedVerb conjugatedVerb;
  bool showSearchBar = false;

  @override
  void initState() {
    ConjugatedVerbViewModel.loadConjugation(widget.verb).then((verb) {
      setState(() {
        conjugatedVerb = verb;
      });
    });
    super.initState();
  }

  Widget _buildAppbar() {
    return AppBar(
      title: showSearchBar
          ? SearchBarMini()
          : Text('${widget.verb}의 동사변형', style: TextStyle(fontFamily: 'Godo')),
      actions: <Widget>[
        IconButton(
          icon: Icon(showSearchBar ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              showSearchBar = !showSearchBar;
            });
          },
        )
      ],
    );
  }

  Widget _buildBody() {
    if (conjugatedVerb == null)
      return InfoCard('로딩 중..');
    else if (conjugatedVerb.conjugations == null)
      return InfoCard('결과가 없습니다.');
    else
      return Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 5.0),
            ...ConjugatedVerbViewModel.types.map((type) => ConjugationCard(
                  koType: type.koType,
                  conjugations: conjugatedVerb.conjugations[type.enType],
                )),
            ...ConjugatedVerbViewModel.pps.map((type) => ConjugationCardPP(
                  koType: type.koType,
                  conjugations: conjugatedVerb.conjugations[type.enType],
                )),
            ...ConjugatedVerbViewModel.extra.map((type) => ConjugationCardExtra(
                  koType: type.koType,
                  conjugations: conjugatedVerb.conjugations[type.enType],
                )),
            SizedBox(height: 10.0),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }
}
