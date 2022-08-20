import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/auth/login_view.view.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/home/home.view.dart';

class LoggedInView extends StatelessWidget {
  LoggedInView({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return const EcomHomeView();
    } else {
      return const LoginView();
    }
  }
}
