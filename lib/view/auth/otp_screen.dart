import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:great_gpt/utils/global_colors.dart';
import 'package:great_gpt/utils/global_values.dart';
import 'package:great_gpt/utils/text.dart';
import 'package:great_gpt/view_model/login_view_model.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

FocusNode focusNode = FocusNode();

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<LoginViewModel>(context, listen: true).isLoading;
    final pro = context.watch<LoginViewModel>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      body: SafeArea(
        child: isLoading
            ? const Center(
              child:   SpinKitThreeBounce(
                color: AppColors.appColor,
                size: 18,
              ),
            )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: pro.otpFormKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Text(
                        'VERIFICATION CODE',
                        style: GoogleFonts.robotoMono(
                          color: AppColors.hashColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          fontSize: 20,
                        ),
                      ),
                      const SpaceWH(
                        height: 8.0,
                      ),
                      Text(
                        'Please enter the verification code that we have sent to your phonenumber',
                        style: TextStyles.onText(
                            15, FontWeight.w500, AppColors.kblack),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: size.width,
                          child: Pinput(
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsRetrieverApi,
                            listenForMultipleSmsOnAndroid: true,
                            showCursor: true,
                            cursor: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 21,
                                height: 1,
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(137, 146, 160, 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            length: 6,
                            controller: pro.otpController,
                            focusNode: focusNode,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 20, color: AppColors.kblack),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(232, 232, 235, 241),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 20, color: AppColors.kblack),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.05999999865889549),
                                    offset: Offset(0, 3),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                            ),
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Enter 6 digit OTP";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.05,
                        ),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  AppColors.appColor),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            onPressed: () async {
                              if (pro.otpFormKey.currentState!.validate()) {
                                pro.signInPhoneOtp(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Verify",
                                style: TextStyles.onText(
                                  15,
                                  FontWeight.bold,
                                  AppColors.kwhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SpaceWH(
                        height: size.width * 0.12,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
