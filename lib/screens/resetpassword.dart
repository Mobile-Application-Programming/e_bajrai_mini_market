import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/screens/signup.dart';
import 'package:e_bajrai_mini_market/widgets/changescreens.dart';
import 'package:e_bajrai_mini_market/widgets/mytextformfield.dart';
import 'package:e_bajrai_mini_market/widgets/passwordtextformfield.dart';
import 'package:e_bajrai_mini_market/screens/homepageAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
//String email="";

bool obserText = true;

class _ResetPasswordState extends State<ResetPassword> {
late String email;

  Widget _buildAllPart() {
    return Container(
        height: 400,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextFormField(
              name: "Email",
              onChanged: (value) {
                setState(() {
                  email = value!;
                });
              },
              validator: (value) {
                if (value == "") {
                  return "Please fill Email";
                } else if (!regExp.hasMatch(value!)) {
                  return "Email is invalid";
                }
                return "";
              },
            ),
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#53B175"), // Background color
                ),
                child: Text("End Request"),
              ),
            ),
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
