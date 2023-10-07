import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:great_gpt/utils/global_colors.dart';
import 'package:great_gpt/utils/global_values.dart';
import 'package:great_gpt/utils/text.dart';
import 'package:great_gpt/view/auth/login_screen.dart';
import 'package:great_gpt/view/home/home_screen.dart';
import 'package:great_gpt/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pro =context.watch<AuthViewModel>();
    final size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      backgroundColor: AppColors.kwhite,
      splashIconSize: double.infinity,
      duration: 3000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Great GPT",
            style: TextStyles.splashHead(),
          ),
          AppSizes.kHeight20,
          SizedBox(
            width: size.width * 0.8,
            child: Image.asset("assets/images/splash.png"),
          ),
        ],
      ),
      splashTransition: SplashTransition.fadeTransition,
      nextScreen:pro.isLoggedIn
      ?const HomeScreen()
      :const HomeScreen() ,
    );
  }
}
