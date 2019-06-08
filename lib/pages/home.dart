import 'package:flutter/material.dart';
import 'package:pt_conjugate/widgets/recommendation_verbs.dart';
import 'package:pt_conjugate/widgets/search_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1.0),
      appBar: AppBar(
        title: Text(
          '포르투갈어 동사변형',
          style: TextStyle(fontFamily: 'Godo'),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SearchBar(),
          RecommendationVerbs(),
        ],
      ),
    );
  }
}
