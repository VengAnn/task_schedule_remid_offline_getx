import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final double? sizeText;
  final FontWeight fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;

  const SimpleText({
    super.key,
    required this.text,
    this.sizeText,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Text(
      text,
      style: TextStyle(
        fontSize: sizeText ?? dimensions.fontSize20 / 1.5,
        fontWeight: fontWeight,
        color: textColor ?? Colors.black,
      ),
      textAlign: textAlign,
    );
  }
}
