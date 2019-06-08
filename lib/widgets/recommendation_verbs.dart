import 'package:flutter/material.dart';
import 'package:pt_conjugate/models/verb_index.dart';
import 'package:pt_conjugate/pages/conjugator.dart';

class RecommendationVerbs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
      child: Column(
        children: <Widget>[
          RegularVerbCard(),
          IrregularVerbCard(),
        ],
      ),
    );
  }
}

class RegularVerbCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundCard(
      child: Column(
        children: [
          CardHeader(title: '규칙동사'),
          ...ListTile.divideTiles(
            context: context,
            tiles: VerbIndexViewModel.regularVerbs.map((verb) {
              return CardContent(verb: verb, showDescription: true);
            }),
          ),
        ],
      ),
    );
  }
}

class IrregularVerbCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundCard(
      child: Column(
        children: [
          CardHeader(title: '불규칙동사'),
          ...ListTile.divideTiles(
            context: context,
            tiles: VerbIndexViewModel.irregularVerbs.map((verb) {
              return CardContent(verb: verb);
            }),
          ),
        ],
      ),
    );
  }
}

class RoundCard extends StatelessWidget {
  final Widget child;

  RoundCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: child,
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  CardHeader({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: ListTile(
        title: TitleText(title),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;

  TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 28,
        fontFamily: 'Godo',
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final Verb verb;
  final bool showDescription;

  CardContent({this.verb, this.showDescription = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        showDescription ? '[${verb.description}] ${verb.verb}' : verb.verb,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(verb.mean, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ConjugatorPage(verb.verb)));
      },
    );
  }
}
