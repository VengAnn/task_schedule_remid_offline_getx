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
    final dimensions = Dimensions(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle(dimensions),
        ),
        SizedBox(height: dimensions.height5),
        // Container
        Container(
          height: dimensions.height20 * 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(dimensions.radius15),
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
                  style: subTitleStyle(dimensions),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleStyle(dimensions),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: dimensions.width10,
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
