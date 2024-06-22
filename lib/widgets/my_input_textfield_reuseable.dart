import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/app_style.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

class MyInputTextFieldReusable extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? textEditingController;

  const MyInputTextFieldReusable({
    super.key,
    required this.title,
    required this.hint,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        SizedBox(height: Dimensions.height5),
        // Container
        Container(
          height: Dimensions.height20 * 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: false,
                  cursorColor: Colors.grey[600],
                  controller: textEditingController,
                  style: subTitleStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleStyle,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
