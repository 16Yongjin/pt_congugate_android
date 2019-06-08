import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pt_conjugate/utils/group_by.dart';

class ConjugatedVerbViewModel {
  static Future<ConjugatedVerb> loadConjugation(String verb) async {
    try {
      String jsonString = await rootBundle
          .loadString('assets/verbs/${verb.substring(0, 1)}/$verb.json');
      Map parsedJson = json.decode(jsonString);

      return ConjugatedVerb.fromJson(parsedJson);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 동사변형 2인칭 표시 여부
  static bool rejectSecond = true;

  static Map<int, int> secondRejectedVerbSort = {0: 0, 2: 1, 3: 2, 5: 3, 6: 4};

  static int verbSortProxy(int sort) {
    return rejectSecond ? secondRejectedVerbSort[sort] : sort;
  }

  static List<String> get subjects {
    return rejectSecond
        ? ['Eu', 'Você', 'Nós', 'Vocês']
        : ['Eu', 'Tu', 'Você', 'Nós', 'Vós', 'Vocês'];
  }

  static String getSubject(int sort) {
    return subjects[verbSortProxy(sort)];
  }

  static List<VerbType> types = [
    VerbType('indicative/present', '직설법 / 현재'),
    VerbType('indicative/preterite', '직설법 / 완전과거'),
    VerbType('indicative/imperfect', '직설법 / 불완전과거'),
    VerbType('indicative/pluperfect', '직설법 / 단순대과거'),
    VerbType('indicative/future', '직설법 / 미래'),
    VerbType('conditional', '직설법 / 과거미래'),
    VerbType('subjunctive/present', '접속법 / 현재'),
    VerbType('subjunctive/imperfect', '접속법 / 불완전과거'),
    VerbType('subjunctive/preterite', '접속법 / 미래'),
    VerbType('infinitive/personal', '접속법 / 인칭부정사'),
    VerbType('imperative/affirmative', '명령형 / 긍정'),
    VerbType('imperative/negative', '명령형 / 부정'),
  ];

  static List<String> ppSubjects = ['단수', '복수'];

  static List<VerbType> pps = [
    VerbType('pastparticiple/masculine', '과거분사 / 남성'),
    VerbType('pastparticiple/feminine', '과거분사 / 여성'),
  ];

  static List<VerbType> extra = [
    VerbType('gerund', '동명사'),
    VerbType('infinitive/impersonal', '비인칭부정사'),
  ];
}

class VerbType {
  final String enType;
  final String koType;

  VerbType(this.enType, this.koType);
}

class ConjugatedVerb {
  Map<String, List<Conjugations>> conjugations;
  String word;

  ConjugatedVerb({this.conjugations, this.word});

  ConjugatedVerb.fromJson(Map<String, dynamic> json) {
    if (json['conjugations'] != null) {
      List<Conjugations> conjugationList = List();

      json['conjugations'].forEach((v) {
        conjugationList.add(Conjugations.fromJson(v));
      });

      if (ConjugatedVerbViewModel.rejectSecond)
        conjugationList.removeWhere((c) =>
            c.groupSort != 3 && c.groupSort != 4 && c.sort == 1 || c.sort == 4);

      conjugations = groupBy(conjugationList, (c) => c.group);
    }
    word = json['word'];
  }
}

class Conjugations {
  String group;
  int groupSort;
  int sort;
  String value;

  Conjugations({this.group, this.groupSort, this.sort, this.value});

  Conjugations.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    groupSort = json['group_sort'];
    sort = json['sort'];
    value = json['value'];
  }
}
