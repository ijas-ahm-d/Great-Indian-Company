import 'package:flutter/material.dart';
import 'package:great_gpt/view/auth/login_screen.dart';
import 'package:great_gpt/view/auth/otp_screen.dart';
import 'package:great_gpt/view/gpt/home_screen.dart';
import 'package:great_gpt/view/splash_screen.dart';

class Navigations {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const loginScreen = "/userLogin";
  static const otpScreen = "/userOtp";
 static const splashScreen = "/splash_screen";
  static const homeScreen = "/home_screen";

static Map<String, Widget Function(BuildContext)> routes() {
    Map<String, Widget Function(BuildContext)> routes = {
      "/splash_screen": (context) => const SplashScreen(),
      "/userLogin": (context) =>const LoginScreen(),
      "/userOtp": (context) =>const OtpScreen(),
      "/home_screen": (context) => const HomeScreen(),
     
    };
    return routes;
  }

}
