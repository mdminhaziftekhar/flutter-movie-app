import 'package:flutter/material.dart';

import '../constants/typography.dart';


class AppButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width, height;

  const AppButtonWidget({
    Key? key,
    this.width = double.infinity,
    this.height = 58,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height?? 58,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color(0xFF88DA09),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: Text(
            buttonText,
            style: bodyFont18SemiBold,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
