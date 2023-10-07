import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:great_gpt/utils/global_colors.dart';
import 'package:great_gpt/utils/global_values.dart';
import 'package:great_gpt/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerValue = context.watch<LoginViewModel>();
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      body: Form(
        key: providerValue.loginFormKey,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode curentFocus = FocusScope.of(context);
            if (!curentFocus.hasPrimaryFocus) {
              curentFocus.unfocus();
            }
          },
          child: ListView(
            children: [
              //*****------------HEADING ----------------*****//
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06,
                    top: size.width * 0.06,
                    right: size.width * 0.06),
                child: Text(
                  "WELCOME TO ",
                  style: GoogleFonts.robotoMono(
                    color: AppColors.grayText,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, right: size.width * 0.06),
                child: Text(
                  "Great GPT",
                  style: GoogleFonts.robotoMono(
                    fontSize: 30,
                    letterSpacing: 3,
                    color: AppColors.kblack,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SpaceWH(
                height: size.height * 0.1,
              ),
              Text(
                "sign up this page for accessing gpt.",
                style: GoogleFonts.robotoMono(),
                textAlign: TextAlign.center,
              ),

              SpaceWH(
                height: size.width * 0.05,
              ),

              //*****------------PHONENUMBER ----------------*****//

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07, vertical: size.width * 0.03),
                child: TextFormField(
                  controller: providerValue.phoneNumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phonenumber is required";
                    } else if (value.length != 10) {
                      return "Enter a valid Phonenumber";
                    } else if (value.length > 10) {
                      return "Please check your Phonenumber";
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    fillColor: const Color(0xFF262A34),
                    filled: true,
                    prefixText: "+91 ",
                    prefixIconColor: AppColors.hashColor,
                    prefixIcon: const Icon(Icons.phone),
                    counterStyle:
                        GoogleFonts.robotoMono(color: AppColors.kwhite),
                    hintText: "Phonenumber",
                    hintStyle: GoogleFonts.robotoMono(
                      fontSize: 16,
                      color: const Color(0xFF5D5F65),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  style: GoogleFonts.robotoMono(
                    fontSize: size.width * 0.045,
                    color: AppColors.kwhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppSizes.kHeight10,
              //*****------------ sign up ----------------*****//

              providerValue.isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.appColor,
                ),
              )
              :Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.2,
                  top: size.width * 0.035,
                  right: size.width * 0.2,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(AppColors.appColor),
                    overlayColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () async {
                    if (providerValue.loginFormKey.currentState!.validate()) {
                      providerValue.signInWithPhone(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.robotoMono(
                        color: AppColors.kwhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
