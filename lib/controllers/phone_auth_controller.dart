import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfood/routing/routes.dart';
import 'package:myfood/widgets/dialogs.dart';

class PhoneAuthController extends GetxController {
  bool showOTPField = false;
  String verificationID, otp;
  var phoneTEController = TextEditingController();
  Future sendOTP() async {
    try {
      showLoader('Sending OTP');
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${phoneTEController.text}',
          codeSent: (String verificationID, int resendToken) {
            hideLoader();
            print('Verification ID : $verificationID');
            showOTPField = true;
            this.verificationID = verificationID;
            update();
          },
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            signInWithPhoneNumber();
            print('running verification completed');
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) {
            showError();
          },
          codeAutoRetrievalTimeout: (String code) {});
    } catch (e, s) {
      showError();
    }
  }

  Future signInWithPhoneNumber() async {
    try {
      showLoader('Wait for few seconds');
      var result = await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationID, smsCode: otp));
      hideLoader();
      if (result.user != null) {
        Get.offAllNamed(RouteList.homeScreen);
      }
    } catch (e, s) {
      showError();
    }
  }

  Future logout() async {
    showLoader('Wait for few seconds');
    await FirebaseAuth.instance.signOut();
    hideLoader();
    Get.offAllNamed(RouteList.loginScreen);
  }
}
