import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

// TextStyle
TextStyle get subHeadingStyle {
  return TextStyle(
    fontFamily: 'Lato',
    fontSize: Dimensions.fontSize20,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
}

// TextStyle Header
TextStyle get headingStyle {
  return TextStyle(
    fontFamily: 'Lato',
    fontSize: (Dimensions.fontSize20 * 2) - 10,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// TextStyle title
TextStyle get titleStyle {
  return TextStyle(
    fontFamily: 'Lato',
    fontSize: Dimensions.fontSize20 - 4,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// TextStyle subTitle
TextStyle get subTitleStyle {
  return TextStyle(
    fontFamily: 'Lato',
    fontSize: Dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w400,
    color: Colors.grey[400],
  );
}

TextStyle get styleColorWhite {
  return TextStyle(
    fontFamily: 'Lato',
    fontSize: Dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
