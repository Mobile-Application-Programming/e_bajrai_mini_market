// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  get child => null;
  ProductProvider productProvider;

  Widget _buildSingleContainer({String? startText, String? endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText!,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText!,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSingleTextFormField({String? name}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  bool edit = false;

  Widget _buildContainerPart(){
    List<UserModel> userModel = productProvider.userModelList;
    return Column(
      children: userModel.map((e){
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSingleContainer(
              endText: e.userName,
              startText: "Name",
            ),
            _buildSingleContainer(
              endText: e.userEmail,
              startText: "Email",
            ),
            _buildSingleContainer(
              endText: e.userPhoneNumber,
              startText: "Phone Number",
            ),
            _buildSingleContainer(
              endText: e.userGender,
              startText: "Gender",
            ),
          ],
        ),
      }).toList(),
    );
  }

Widget _buildTextFormFieldPart(){
    List<UserModel> userModel = productProvider.userModelList;
    return Column(
      children: userModel.map((e){
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSingleTextFormField(name: e.userName),
                _buildSingleTextFormField(name: e.userEmail),
                _buildSingleTextFormField(name: e.userPhoneNumber),
                _buildSingleTextFormField(name: e.userGender),
              ],
            )
          ],
        ),
      }).toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.green,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit == false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage(),),);
                  });
                },
        backgroundColor: Colors.lightGreen,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          edit == false
              ? IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.green,
                  ),
                )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        maxRadius: 65,
                        backgroundImage: AssetImage("images/user.jpg"),
                      )
                    ],
                  ),
                ),
                edit == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 225, top: 80),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 300,
                      child: edit == true
                          ? _buildTextFormFieldPart()
                          : _buildContainerPart(),
                    ),
                  ]),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                width: 200,
                child: edit == false
                    ? TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightGreen)),
                        onPressed: () {
                          setState(() {
                            edit = true;
                          });
                        },
                        child: child)
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
