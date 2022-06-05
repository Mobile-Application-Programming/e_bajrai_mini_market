import 'package:e_bajrai_mini_market/screens/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:e_bajrai_mini_market/screens/signup.dart';
import 'package:e_bajrai_mini_market/screens/login.dart';
import 'package:e_bajrai_mini_market/screens/detailscreen.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
import 'package:e_bajrai_mini_market/screens/homepageAdmin.dart';
import 'package:e_bajrai_mini_market/screens/makepayment.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:e_bajrai_mini_market/provider/product_provider.dart';
import 'package:e_bajrai_mini_market/provider/category_provider.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context,snapShot){
      //     if(snapShot.hasData){
      //       return HomePage();
      //     }
      //     else {
      //       return SignUp();
      //     }
      // }),
      home: SignUp(),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(),
//       debugShowCheckedModeBanner: false,
//       home: MultiProvider(
//         providers: [
//           //Provider<ProductProvider>(create: (ctx)=>ProductProvider()),
//           Provider<CategoryProvider>(create: (ctx)=>CategoryProvider()),
//         ],
//         child: SignUp()
//       ),
//     );
//   }
// }


