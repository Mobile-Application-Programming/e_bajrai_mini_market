
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onChanged;
  final String? name;

  MyTextFormField({this.onChanged, this.name, this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}
