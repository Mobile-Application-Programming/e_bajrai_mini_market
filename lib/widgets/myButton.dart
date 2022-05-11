import 'dart:html';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String? name;
  MyButton({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlue, // Background color
        ),
        child: Text(name!),
      ),
    );
  }
}
