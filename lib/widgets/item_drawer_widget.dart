import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class ItemDrawerWidget extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const ItemDrawerWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ItemDrawerWidgetState createState() => _ItemDrawerWidgetState();
}

class _ItemDrawerWidgetState extends State<ItemDrawerWidget> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        right: Dimensions.width20,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
          });
          // delay a bit to see something tap on or see animation
          Future.delayed(const Duration(milliseconds: 100), () {
            widget.onTap();
          });
        },
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: Dimensions.height20 * 2,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  //color: !_isTapped ? Colors.white : null,
                  gradient: _isTapped
                      ? LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.7),
                            Colors.blue.withOpacity(0.3)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: _isTapped ? Colors.black : Colors.black,
                    ),
                    SizedBox(width: Dimensions.width20),
                    SimpleText(
                      text: widget.text,
                      sizeText: Dimensions.fontSize15,
                      textColor: _isTapped ? Colors.black : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 2,
              ),
              child: Divider(
                thickness: 1,
                color: _isTapped ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
