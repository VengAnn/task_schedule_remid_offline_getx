import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class ItemDrawerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;
  final bool isActive;

  const ItemDrawerWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Padding(
      padding: EdgeInsets.only(
        left: dimensions.width20,
        right: dimensions.width20,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: dimensions.height20 * 2,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: isActive
                      ? LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.7),
                            Colors.blue.withOpacity(0.3)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(dimensions.radius10),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: isActive ? Colors.black : Colors.black,
                    ),
                    SizedBox(width: dimensions.width20),
                    SimpleText(
                      text: text,
                      sizeText: dimensions.fontSize15,
                      textColor: isActive ? Colors.black : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: dimensions.width20 * 2,
              ),
              child: Divider(
                thickness: 1,
                color: isActive ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
