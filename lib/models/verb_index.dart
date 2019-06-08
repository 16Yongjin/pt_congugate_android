import 'dart:convert';
import 'package:flutter/services.dart';

class VerbIndexViewModel {
  static Map<String, List<AcVerb>> verbIndex;

  static Future loadVerbIndex() async {
    try {
      String jsonString = await rootBundle.loadString('assets/verb_list.json');
      Map parsedJson = json.decode(jsonString);
      verbIndex = parsedJson.map((a, v) =>
          MapEntry(a, (v as List).map((i) => AcVerb(i[0], i[1])).toList()));
    } catch (e) {
      print(e);
    }
  }

  static bool isInvalidQuery(String query) =>
      query.isEmpty ||
      !(97 <= query.codeUnitAt(0) && query.codeUnitAt(0) <= 122);

  static List<AcVerb> suggestVerbs(String query) {
    query = query.toLowerCase();

    if (isInvalidQuery(query)) return [];

    return verbIndex[query.substring(0, 1)]
        .where((AcVerb v) => v.verb.startsWith(query))
        .take(5)
        .toList();
  }

  static List<Verb> regularVerbs = [
    Verb('falar', '말하다', '-ar 동사'),
    Verb('comer', '먹다', '-er 동사'),
    Verb('partir', '떠나다', '-ir 동사'),
  ];

  static List<Verb> irregularVerbs = [
    Verb('ser', '이다'),
    Verb('estar', '있다/이다'),
    Verb('ir', '가다'),
    Verb('vir', '오다'),
    Verb('ver', '보다'),
    Verb('ter', '가지다/있다'),
    Verb('fazer', '하다/만들다'),
    Verb('poder', '할 수 있다.'),
    Verb('querer', '원하다'),
    Verb('dar', '주다'),
    Verb('dizer', '말하다'),
    Verb('trazer', '가져오다'),
    Verb('saber', '알다'),
    Verb('pôr', '놓다'),
    Verb('pedir', '부탁하다'),
    Verb('ler', '읽다'),
    Verb('ouvir', '듣다'),
    Verb('subir', '오르다'),
    Verb('rir', '웃다'),
    Verb('sair', '나가다'),
    Verb('passear', '산책하다'),
    Verb('sentir', '느끼다'),
    Verb('dormir', '자다'),
    Verb('perder', '잃다'),
  ];
}

class Verb {
  final String verb;
  final String mean;
  String description;

  Verb(this.verb, this.mean, [this.description]);
}

class AcVerb {
  final String verb;
  final String mean;

  AcVerb(this.verb, this.mean);

  factory AcVerb.fromJson(Map<String, dynamic> parsedJson) {
    return AcVerb(parsedJson[0], parsedJson[1]);
  }
}
