import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:great_gpt/utils/colors.dart';
import 'package:great_gpt/widgets/text_widget.dart';

// class ChatWidget extends StatelessWidget {
//   const ChatWidget({super.key, required this.msg, required this.currentindex});

//   final String msg;
//   final int currentindex;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Material(
//           color: currentindex == 0 ? scaffoldBackgroundColor : cardColor,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 30,
//                   width: 30,
//                   child: currentindex == 0
//                       ? const Icon(Icons.person)
//                       : const Icon(Icons.logo_dev),
//                 ),
//                 // Image.asset(
//                 //   currentindex == 0 ? AssetManger.person : AssetManger.chatLogo,
//                 //   height: 30,
//                 //   width: 30,
//                 // ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Expanded(
//                   child: TextWidget(
//                     label: msg,
//                   ),
//                 ),
//                 currentindex == 0
//                     ? const SizedBox.shrink()
//                     : Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.thumb_up_alt_outlined,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.thumb_down_off_alt_outlined,
//                             ),
//                           )
//                         ],
//                       ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                                SizedBox(
                  height: 30,
                  width: 30,
                  child: chatIndex == 0
                      ? const Icon(Icons.person)
                      : const Icon(Icons.logo_dev),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: chatIndex == 0
                      ? TextWidget(
                          label: msg,
                        )
                      : shouldAnimate
                          ? DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      msg.trim(),
                                    ),
                                  ]),
                            )
                          : Text(
                              msg.trim(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}