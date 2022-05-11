import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool? obserText;
  final FormFieldValidator<String>? validator;
  final String? name;
  final Function()? onTap;
  final FormFieldValidator<String>? onChanged;

  PasswordTextFormField(
      {this.onChanged, this.onTap, this.name, this.obserText, this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obserText!,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            obserText == true ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
