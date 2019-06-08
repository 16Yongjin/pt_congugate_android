import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pt_conjugate/pages/conjugator.dart';
import 'package:pt_conjugate/models/verb_index.dart';

class SearchBarMini extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarMini> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  get _isSearchTextEmpty =>
      _textEditingController.text.isEmpty ||
      _textEditingController.text == null;

  @override
  Widget build(BuildContext context) {
    _textEditingController.addListener(() {
      print(_textEditingController.text);
    });

    return TypeAheadField(
        getImmediateSuggestions: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: _textEditingController,
          onSubmitted: (_) {
            var suggestedVerbs =
                VerbIndexViewModel.suggestVerbs(_textEditingController.text);
            if (suggestedVerbs.isNotEmpty) {
              print(suggestedVerbs[0].verb);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      ConjugatorPage(suggestedVerbs[0].verb)));
            }
          },
          autofocus: true,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            decorationThickness: 0,
            fontFamily: 'Godo',
          ),
          decoration: InputDecoration(
              hintText: '동사 입력',
              hintStyle: TextStyle(
                color: Colors.white70,
              )),
        ),
        suggestionsCallback: (pattern) =>
            VerbIndexViewModel.suggestVerbs(pattern),
        itemBuilder: (context, AcVerb suggestion) => ListTile(
              title: Text(suggestion.verb, style: TextStyle(fontSize: 22)),
              subtitle: suggestion.mean != null ? Text(suggestion.mean) : null,
            ),
        onSuggestionSelected: (AcVerb suggestion) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ConjugatorPage(suggestion.verb)));
        },
        errorBuilder: (context, error) => Text('$error'),
        noItemsFoundBuilder: (context) => _isSearchTextEmpty
            ? SizedBox()
            : ListTile(title: Text('동사를 찾지 못했습니다.')));
  }
}
