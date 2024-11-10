import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBottomButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var backgroundcolor;
  // ignore: prefer_typing_uninitialized_variables
  var foregroundColor;
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  var onPressed;

  CustomBottomButton({
    super.key,
    required this.backgroundcolor,
    required this.foregroundColor,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundcolor,
          foregroundColor: foregroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.rubik16w2700,
        ),
      ),
    );
  }
}
