import 'package:flutter/material.dart';

import '../../resource/colors_manager.dart'; /// Importing color constants
import '../../resource/strings_manager.dart'; /// Importing string constants

class CommonWelcomeTitleView extends StatelessWidget {
  final String title; /// Title text

  /// Constructor to initialize the title
  const CommonWelcomeTitleView({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        /// Building a rich text with two spans: "Welcome to" and the title
        text: StringManager.welcomeTo, /// "Welcome to" text from string constants
        style: TextStyle(
          fontSize: 18, /// Font size
          fontWeight: FontWeight.bold, /// Bold font weight
          color: ColorManager.colorBlack, /// Text color from color constants
        ),
        children: [
          const TextSpan(text: ' '), /// Spacer between "Welcome to" and the title
          TextSpan(
            text: title, /// Title text passed from the constructor
            style: TextStyle(
              fontSize: 18, /// Font size
              fontWeight: FontWeight.bold, /// Bold font weight
              color: ColorManager.primary, /// Title text color from color constants
            ),
          ),
        ],
      ),
    );
  }
}
