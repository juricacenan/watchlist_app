import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String languageType;
  List languageListItem = ['English', 'Hrvatski'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 20),
        child: DropdownButton(
          hint: Text('Select your language: '),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 36,
          isExpanded: true,
          value: languageType,
          onChanged: (newLanguage) {
            setState(() {
              languageType = newLanguage;
            });
          },
          items: languageListItem.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),
        ),
      ),
    );
  }
}
