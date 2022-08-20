import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/utils/toats_msg.utils.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/auth/otp_verification.view.dart';
import 'package:flutter_statemanagement_practice/EcomAppUsingGetx/view/home/home.view.dart';
import 'package:get/get.dart';

class LoginViewController extends GetxController {
  //create firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationId = "";
  bool isLoading = false;

  //crate a function fro verify phone

  void verifyPhoneNumber() async {
    isLoading = true;
    update();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: (PhoneAuthCredential credential) {
          _auth.signInWithCredential(credential);
          showAlert("Verified");
        },
        verificationFailed: (FirebaseAuthException exception) {
          showAlert("Verification Failed");
        },
        codeSent: (String _verificationId, int? forcedRespondToken) {
          showAlert("Verification code sent");
          verificationId = _verificationId;
          Get.to(() => const OtpVerificationScreen());
        },
        codeAutoRetrievalTimeout: (String _verificationId) {
          verificationId = _verificationId;
        },
      );
    } catch (e) {
      showAlert("Error Occurred $e");
    }
  }

  //for signin
  void signInWithPhoneNumber() async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );
      //for signIn with credential
      var signInUser = await _auth.signInWithCredential(authCredential);

      //for storing the user data
      final User? user = signInUser.user;
      showAlert("Successfully, User UID : ${user!.uid}");
      Get.to(() => const EcomHomeView());
    } catch (e) {
      showAlert("Error Occurred $e");
    }
  }
}
