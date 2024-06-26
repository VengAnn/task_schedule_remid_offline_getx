import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/app_style.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? ontap;
  const MyButton({
    required this.label,
    this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: dimensions.width20 * 5,
        height: dimensions.height20 * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dimensions.radius10),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            label,
            style: styleColorWhite(context),
          ),
        ),
      ),
    );
  }
}
