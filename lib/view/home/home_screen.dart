import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:great_gpt/utils/colors.dart';
import 'package:great_gpt/utils/global_colors.dart';
import 'package:great_gpt/utils/global_snackbar.dart';
import 'package:great_gpt/utils/global_values.dart';
import 'package:great_gpt/view_model/chat_view_model.dart';
import 'package:great_gpt/widgets/chat_widget.dart';
import 'package:provider/provider.dart';

// GPT Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isTyping = true;
  final ScrollController _listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatPro = Provider.of<ChatViewModel>(context);
    return Scaffold(
      // backgroundColor: AppColors.kblack,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 65, 60, 60),
        title: const Text(
          "GPT Section",
          style: TextStyle(
            color: AppColors.kwhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
            },
            icon: const Icon(Icons.autorenew),
            color: AppColors.spRed,
            iconSize: 30,
          ),
          AppSizes.kWidth20
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              controller: _listScrollController,
              itemCount: chatPro.getChatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  msg: chatPro.getChatList[index].msg,
                  chatIndex: chatPro.getChatList[index].chatIndex,
                  shouldAnimate: chatPro.getChatList.length - 1 == index,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: _controller,
                        onSubmitted: (v) async {
                          await sendMessage(
                              chatPro: chatPro, );
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: "How can i help you",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(
                            chatPro: chatPro);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.kwhite,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ],
      )),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessage({
 
    required ChatViewModel chatPro
  }) async {
    // if (_isTyping) {
    //   CommonSnackBAr.snackBar(
    //     context: context,
    //     data: "You cant Send multiple messages at a time",
    //     color: AppColors.spRed,
    //   );
    //   return;
    // }
    if (_controller.text.isEmpty) {
      CommonSnackBAr.snackBar(
        context: context,
        data: "Please Type a message",
        color: AppColors.warn,
      );
      return;
    }

    try {
      String msg = _controller.text;
      setState(() {
        _isTyping = true;
        chatPro.addUserMessage(msg: msg);
        _controller.clear();
        focusNode.unfocus();
      });

      await chatPro.sendMessageAndGetAnswers(
        msg: msg,
        
      );
      setState(() {});
    } catch (error) {
      CommonSnackBAr.snackBar(
        context: context,
        data: error.toString(),
        color: AppColors.spRed,
      );
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
