// import 'package:flutter/material.dart';

// class TextFormWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType keyType;
//   final bool isPassword;
//   final bool isEmail;
//   final bool isPhone;
//   final bool isUser;
//   final bool isObs;
//   final Size size;
//   final dynamic prefixIcon;
//   const TextFormWidget({
//     super.key,
//     required this.prefixIcon,
//     required this.controller,
//     required this.hintText,
//     required this.keyType,
//     required this.size,
//     this.isPassword = false,
//     this.isEmail = false,
//     this.isPhone = false,
//     this.isUser = false,
//     this.isObs = false,
//   });

//   @override
//   Widget build(BuildContext context) {
  
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyType,
//       validator: (value) {
//         if (isUser) {
//           if (value == null || value.isEmpty) {
//             return "Username is required";
//           }
//         }
//         if (isPhone) {
//           if (value == null || value.isEmpty) {
//             return "Phonenumber is required";
//           } else if (value.length != 10) {
//             return "Enter a valid Phonenumber";
//           }
//         }
//         if (isPassword) {
//           RegExp isUppercase = RegExp(r'^(?=.*?[A-Z])');
//           RegExp islowercase = RegExp(r'^(?=.*?[a-z])');
//           RegExp isOnenumber = RegExp(r'^(?=.*?[0-9])');
//           RegExp islength8 = RegExp(r'^.{8,}');
//           if (value == null || value.isEmpty) {
//             return "Password is required";
//           } else if (!islength8.hasMatch(value)) {
//             return "Password must be 8 or more characters";
//           } else if (!isUppercase.hasMatch(value)) {
//             return "Password must contain atleast one\nUppercase";
//           } else if (!islowercase.hasMatch(value)) {
//             return "Password must contain atleast one\nlowercase";
//           } else if (!isOnenumber.hasMatch(value)) {
//             return "Password must contain atleast\none number";
//           }
//         }

//         if (isEmail) {
//           if (value != null && !EmailValidator.validate(value)) {
//             return "Enter valid email";
//           }
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         fillColor: const Color(0xFF262A34),
//         filled: true,
//         prefixIconColor: hashColor,
//         prefixIcon: prefixIcon,
//         suffixIconColor: kwhite,
//         suffixIcon: isPassword
//             ? IconButton(
//                 splashRadius: 4,
//                 onPressed: () {
//                   context.read<UserLoginViewModel>().showPassword();
//                 },
//                 icon: isShowPassword
//                     ? const Icon(Icons.visibility_off)
//                     : const Icon(Icons.visibility),
//               )
//             : const SizedBox(),
//         counterStyle:  GoogleFonts.robotoMono(color: kwhite),
//         hintText: hintText,
//         hintStyle: hintStyle,
//         border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(15)),
//       ),
//       style: GoogleFonts.robotoMono(
//         fontSize: size.width * 0.045,
//         color: kwhite,
//         fontWeight: FontWeight.bold,
//       ),
//       obscureText: isPassword ? isShowPassword : false,
//     );
//   }
// }