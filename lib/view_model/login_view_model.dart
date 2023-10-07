// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:great_gpt/utils/global_colors.dart';
import 'package:great_gpt/utils/global_keys.dart';
import 'package:great_gpt/utils/global_snackbar.dart';
import 'package:great_gpt/utils/routes/navigations.dart';
// import 'package:great_gpt/view/auth/otp_screen.dart';
// import 'package:great_gpt/view/auth/user_info_screen.dart';
// import 'package:great_gpt/view/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // String? _uid;
  // String? get uid => _uid;

  String _verificationId = "";
  String get verificaionId => _verificationId;

  // setUId(String val) {
  //   _uid = val;
  //   notifyListeners();
  // }

  setVId(String val) {
    _verificationId = val;
    notifyListeners();
  }

  setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  clearController() {
    otpController.clear();
    phoneNumberController.clear();
  }

  void signInWithPhone(BuildContext context) async {
    setLoading(true);
    String phone = phoneNumberController.text.trim();
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          setLoading(false);
          CommonSnackBAr.snackBar(
            context: context,
            data: error.message.toString(),
            color: AppColors.warn,
          );
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          setLoading(false);
          setVId(verificationId);
          Navigator.pushNamed(context, Navigations.otpScreen);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      CommonSnackBAr.snackBar(
        context: context,
        data: e.message.toString(),
        color: AppColors.warn,
      );
    }
  }

  signInPhoneOtp(context) async {
    setLoading(true);
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text,
      );
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // setUId(user.uid);
        onOtpSuccess(context);
      }
      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      CommonSnackBAr.snackBar(
        context: context,
        data: e.message.toString(),
        color: AppColors.warn,
      );
    }
  }

  onOtpSuccess(context) {
    // checkExistingUser().then((value) async {
    //   if (value == true) {
    //      Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return const HomeScreen();
    //     },
    //   ),
    // );
    //   } else {
    //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    //       builder: (context) {
    //         return const UserInfoScreen();
    //       },
    //     ), (route) => false);
    //   }
    // });
    clearController();
    Navigator.pushNamedAndRemoveUntil(
        context, Navigations.homeScreen, (route) => false);
  }

  setLoginStatus() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool(GlobalKeys.userLoggedInLey, true);
    notifyListeners();
  }

  // Future<bool> checkExistingUser() async {
  //   DocumentSnapshot snapshot =
  //       await _firebaseFirestore.collection("users").doc(_uid).get();

  //   if (snapshot.exists) {
  //     log("User Exists");
  //     return true;
  //   } else {
  //     log("New User");
  //     return false;
  //   }
  // }
}
