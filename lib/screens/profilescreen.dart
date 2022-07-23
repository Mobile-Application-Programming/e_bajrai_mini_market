import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/model/usermodel.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/widgets/drawer.dart';
import 'package:e_bajrai_mini_market/widgets/mybutton.dart';
import 'package:e_bajrai_mini_market/widgets/mytextformField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel userModel;
  late TextEditingController phoneNumber;
  late TextEditingController address;
  late TextEditingController userName;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  bool isMale = false;
  void vaildation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All Filed Are Empty"),
        ),
      );
    } else if (userName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (userName.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  late File _pickedImage;

  late PickedFile _image;
  Future<void> getImage({required ImageSource source}) async {
    _image = (await ImagePicker().getImage(source: source))!;
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  late String userUid;

  Future<String> _uploadImage({required File image}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid");
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User? myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser!.uid;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("User").doc(userUid).update({
      "UserName": userName.text,
      "UserNumber": phoneNumber.text,
      "UserImage": imageMap,
      "UserAddress": address.text
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _buildSingleContainer(
      {required Color color,
      required String startText,
      required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 15, color: Colors.black45),
            ),
            Text(
              endText,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  late String userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    address = TextEditingController(text: userModel.userAddress);
    userName = TextEditingController(text: userModel.userName);
    phoneNumber = TextEditingController(text: userModel.userPhoneNumber);
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: userModel.userName,
            startText: "Name",
            color: Colors.transparent,
          ),
          _buildSingleContainer(
            endText: userModel.userEmail,
            startText: "Email",
            color: Colors.transparent,
          ),
          _buildSingleContainer(
            endText: userModel.userPhoneNumber,
            startText: "Phone Number",
            color: Colors.transparent,
          ),
          _buildSingleContainer(
            endText: userModel.userAddress,
            startText: "Address",
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFiledPart() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: userModel.userName,
            startText: "UserName",
            color: Colors.transparent,
          ),
          _buildSingleContainer(
            endText: userModel.userEmail,
            startText: "Email",
            color: Colors.transparent,
          ),
          _buildSingleContainer(
            endText: userModel.userPhoneNumber,
            startText: "Phone Number",
            color: Colors.transparent,
          ),
          _buildSingleContainer(
            endText: userModel.userAddress,
            startText: "Address",
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Color(0xfff8f8f8),
      drawer: DrawerCustomer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            }),
        actions: [
          edit == false
              ? IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                    color: HexColor("#53B175"),
                  ),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: HexColor("#53B175"),
                  ),
                  onPressed: () {
                    vaildation();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('User').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                  children: [
                    ...snapshot.data!.docs.where(
                      (QueryDocumentSnapshot<Object?> element) => element['UserId'].toString()
                      .contains(userUid)).map((QueryDocumentSnapshot<Object?> data) {
                          userModel = UserModel(
                            userEmail: data["UserEmail"],
                            userImage: "",
                            userAddress: "",
                            userName: data["UserName"],
                            userPhoneNumber: data["Phone Number"],
                            cart: _convertCartItems(data["cart"])
                          );
                      
                      return Container(
                        height: 603,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          maxRadius: 65,
                                          backgroundImage: AssetImage("images/user.jpg")
                                          // backgroundImage: _pickedImage == null
                                          //     ? userModel.userImage == null
                                          //         ? const AssetImage(
                                          //             "images/user.png")
                                          //         : NetworkImage(
                                          //             userModel.userImage)
                                          //     : FileImage(_pickedImage)
                                      ),
                                    ],
                                  ),
                                ),
                                edit == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                220,
                                            top: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                110),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              myDialogBox(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: HexColor("#53B175"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Container(
                              height: 350,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: edit == true
                                          ? _buildTextFormFiledPart()
                                          : _buildContainerPart(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: edit == false
                                    ? MyButton(
                                        name: "Edit Profile",
                                        onPressed: () {
                                          setState(() {
                                            edit = true;
                                          });
                                        },
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                );
            }
          )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

  List<CartModel> _convertCartItems(List cartFomDb){
    List<CartModel> _result = [];
    if(cartFomDb.length > 0){
      cartFomDb.forEach((element) {
      _result.add(CartModel.fromMap(element));
    });
    }
    return _result;
  }
