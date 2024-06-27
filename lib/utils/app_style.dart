import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

// TextStyle subHeading
TextStyle subHeadingStyle(Dimensions dimensions) {
  return TextStyle(
    fontSize: dimensions.fontSize20,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
}

// TextStyle heading
TextStyle headingStyle(Dimensions dimensions) {
  return TextStyle(
    fontSize: (dimensions.fontSize20 * 2) - 10,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// TextStyle title
TextStyle titleStyle(Dimensions dimensions) {
  return TextStyle(
    fontSize: dimensions.fontSize20 - 4,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// TextStyle subTitle
TextStyle subTitleStyle(Dimensions dimensions) {
  return TextStyle(
    fontSize: dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w400,
    color: Colors.grey[400],
  );
}

// TextStyle with static color white
TextStyle styleColorWhite(BuildContext context) {
  Dimensions dimensions = Dimensions(context);
  return TextStyle(
    fontSize: dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
