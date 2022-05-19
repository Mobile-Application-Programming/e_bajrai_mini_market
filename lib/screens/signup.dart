
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';
import 'package:e_bajrai_mini_market/widgets/changescreens.dart';
import 'package:e_bajrai_mini_market/widgets/mytextformfield.dart';
import 'package:e_bajrai_mini_market/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/myButton.dart';
import 'package:hexcolor/hexcolor.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obserText = true;
String? email;
String? phoneNumber;
String? password;
String? username;

class _SignUpState extends State<SignUp> {
  Future<void> validation() async {
    final FormState _form = _formKey.currentState!;
    if (!_form.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
        FirebaseFirestore.instance.collection("User").doc(result.user?.uid).set({
          "UserName": username,
          "UserId": result.user?.uid,
          "UserEmail" : email,
          "Phone Number" : phoneNumber,
        });
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            })
        );
      } on PlatformException catch (e) {
        print(e.message.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    } else {}
  }

  Widget _buildAllTextFormField() {
    return Container(
      height: 330,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            name: "UserName",
            onChanged: (value) {
              setState(() {
                username = value;
              });
            },
            validator: (value) {
              if (value == "") {
                return "Please fill UserName";
              } else if (value!.length < 6) {
                return "UserName is too short";
              }
              return "";
            },
          ),
          MyTextFormField(
            name: "Email",
            onChanged: (value) {
              setState(() {
                email = value;
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
          PasswordTextFormField(
            obserText: obserText,
            name: "Password",
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
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
          MyTextFormField(
            name: "Phone Number",
            onChanged: (value) {
              setState(() {
               phoneNumber = value;
              });
            },
            validator: (value) {
              if (value == "") {
                return "Please fill Phone Number";
              } else if (value!.length < 11) {
                return "Phone Number Must Be 11";
              }
              return "";
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      height: 440,
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          Container(
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                validation();
              },
              style: ElevatedButton.styleFrom(
                primary: HexColor("#53B175"), // Background color
              ),
              child: Text("Sign Up"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ChangeScreen(
            name: "Login",
            whichAccount: "I have Already an Account!",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildBottomPart(),
                ],
              ),
            ),
          ),
        ));
  }
}
