import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

// ignore: must_be_immutable
class DateOrTimePickerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final DateTime selectedDateTime;
  bool show;
  final String? label;

  DateOrTimePickerWidget({
    super.key,
    required this.onTap,
    required this.selectedDateTime,
    this.show = false,
    this.label = 'time',
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: label!,
          fontWeight: FontWeight.bold,
          sizeText: dimensions.fontSize15,
        ),
        SizedBox(height: dimensions.height5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.maxFinite,
            height: dimensions.height20 * 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(dimensions.radius15),
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
                SizedBox(width: dimensions.height10),
                Text(
                  // if show  is true show only date else show only time
                  show
                      ? DateFormat('yyyy-MM-dd').format(selectedDateTime)
                      : DateFormat.jm().format(selectedDateTime),
                  style: TextStyle(fontSize: dimensions.fontSize15),
                ),
                const Spacer(),
                Icon(
                  show ? Icons.date_range_outlined : Icons.access_time,
                ),
                SizedBox(width: dimensions.width10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
