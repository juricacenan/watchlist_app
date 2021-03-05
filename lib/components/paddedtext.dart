import 'package:flutter/material.dart';

class EditedText extends StatelessWidget {
  final String text;

  EditedText(this.text);

  @override
  Widget build(BuildContext contex) {
    return Padding(
        child: Text(
          this.text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        padding: EdgeInsets.only(top: 5, bottom: 5));
  }
}
