import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/app_color.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String titleText;
  final IconData icon;
  final IconData? iconSuffix;
  final bool showIconSuffix;
  final VoidCallback? onTap;
  Function(String)? onChanged;

  TextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.titleText,
    required this.icon,
    this.iconSuffix,
    this.showIconSuffix = false,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //text
        SimpleText(
          text: titleText,
          textColor: AppColor.colorGrey,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //height: Dimensions.height20 * 2.5,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.radius15),
                ),
              ),
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icon),
                  hintText: hintText,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Dimensions.width10,
                  ),
                  suffixIcon: showIconSuffix == true
                      ? GestureDetector(
                          onTap: onTap,
                          child: Icon(iconSuffix),
                        )
                      : const SizedBox(),
                ),
                onChanged: onChanged,
              ),
            ),
            // Show validation message when button is tapped
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width10,
                top: Dimensions.height5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
