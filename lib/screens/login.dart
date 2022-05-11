import 'dart:html';
import 'package:e_bajrai_mini_market/screens/signup.dart';
import 'package:e_bajrai_mini_market/widgets/changescreens.dart';
import 'package:e_bajrai_mini_market/widgets/mytextformfield.dart';
import 'package:e_bajrai_mini_market/widgets/passwordtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
String? email;
String? password;

Future<void> validation() async {
  final FormState _form = _formKey.currentState!;
  if (!_form.validate()) {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      print(result.user?.uid);
    } on PlatformException catch (e) {
      print(e.message.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  } else {}
}

bool obserText = true;

class _LoginState extends State<Login> {
  Widget _buildAllPart() {
    return Container(
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextFormField(
              name: "Email",
              validator: (value) {
                if (value == "") {
                  return "Please fill Email";
                } else if (!regExp.hasMatch(value!)) {
                  return "Email is invalid";
                }
                return "";
              },
            ),
            PasswordTextFormField(
              obserText: obserText,
              name: "Password",
              validator: (value) {
                if (value == "") {
                  return "Please fill password";
                } else if (value!.length < 8) {
                  return "Password is too short";
                }
                return "";
              },
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  obserText = !obserText;
                });
              },
            ),
            MyButton(
              onPressed: () {
                validation();
              },
              name: "Login",
            ),
            ChangeScreen(
              name: "SignUp",
              whichAccount: "I have no Account!",
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => SignUp(),
                  ),
                );
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildAllPart(),
              ],
            ),
          ),
        ));
  }
}
