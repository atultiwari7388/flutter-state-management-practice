import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/auth/logged_in.auth.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/auth/login_view.view.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/home/home.view.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'State Management Practice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoggedInView(),
    );
  }
}
