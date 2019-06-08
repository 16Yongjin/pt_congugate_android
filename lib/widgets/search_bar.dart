import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pt_conjugate/pages/conjugator.dart';
import 'package:pt_conjugate/models/verb_index.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: Colors.blue, width: 4.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: TypeAheadField(
              getImmediateSuggestions: true,
              textFieldConfiguration: TextFieldConfiguration(
                onSubmitted: (_) {
                  var suggestedVerbs = VerbIndexViewModel.suggestVerbs(
                      _textEditingController.text);
                  if (suggestedVerbs.isNotEmpty) {
                    print(suggestedVerbs[0].verb);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ConjugatorPage(suggestedVerbs[0].verb)));
                  }
                },
                controller: _textEditingController,
                autofocus: true,
                style: TextStyle(
                  fontSize: 32,
                  decorationThickness: 0,
                  decorationColor: Colors.white,
                  fontFamily: 'Godo',
                ),
                decoration: InputDecoration(
                  hintText: '동사 입력',
                ),
              ),
              suggestionsCallback: (pattern) =>
                  VerbIndexViewModel.suggestVerbs(pattern),
              itemBuilder: (context, AcVerb suggestion) => ListTile(
                    title:
                        Text(suggestion.verb, style: TextStyle(fontSize: 22)),
                    subtitle:
                        suggestion.mean != null ? Text(suggestion.mean) : null,
                  ),
              onSuggestionSelected: (AcVerb suggestion) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConjugatorPage(suggestion.verb)));
              },
              errorBuilder: (context, error) => Text('$error'),
              noItemsFoundBuilder: (context) => _isSearchTextEmpty
                  ? SizedBox()
                  : ListTile(title: Text('동사를 찾지 못했습니다.'))),
        ),
      ),
    );
  }
}
