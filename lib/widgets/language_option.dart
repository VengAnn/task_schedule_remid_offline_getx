import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class LanguageOption extends StatelessWidget {
  final String textLanguage;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final double? sizeText;

  const LanguageOption({
    super.key,
    required this.textLanguage,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    this.sizeText,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: dimensions.width10),
        padding: EdgeInsets.all(dimensions.width20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(dimensions.radius10),
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: dimensions.width20 * 2.5,
            ),
            SizedBox(height: dimensions.width5),
            SimpleText(
              text: textLanguage,
              fontWeight: FontWeight.bold,
              sizeText: sizeText,
            ),
          ],
        ),
      ),
    );
  }
}
