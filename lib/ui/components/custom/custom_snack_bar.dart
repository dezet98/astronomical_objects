import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSnackBar {
  static show(BuildContext context, String contentText, String actionText,
      VoidCallback actionOnPressed) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(Dimensions.small),
        content: Text(contentText),
        action: SnackBarAction(
          label: actionText,
          onPressed: actionOnPressed,
        ),
      ),
    );
  }
}
