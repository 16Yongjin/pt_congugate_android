import 'package:flutter/material.dart';
import 'package:pt_conjugate/pages/home.dart';
import 'package:pt_conjugate/models/verb_index.dart';
import 'package:flutter/services.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  VerbIndexViewModel.loadVerbIndex();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '포르투갈어 동사변형',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
