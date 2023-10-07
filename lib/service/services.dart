import 'package:flutter/material.dart';
import 'package:great_gpt/utils/colors.dart';
import 'package:great_gpt/widgets/drop_down_widget.dart';
import 'package:great_gpt/widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20,
          ),
        ),
      ),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return const  Padding(
          padding:  EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Flexible(
                child: TextWidget(
                  label: "Choose Model:",
                  fontsize: 16,
                ),
              ),
              Flexible(
                flex: 2,
                child: ModelsDrowDownWidget(),
              )
            ],
          ),
        );
      },
    );
  }
}