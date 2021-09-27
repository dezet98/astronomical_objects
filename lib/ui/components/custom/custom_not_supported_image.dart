import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomNotSupportedImage extends StatelessWidget {
  final double? paddingTop;

  const CustomNotSupportedImage({this.paddingTop, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop ?? 0.0),
        child: const Icon(
          Icons.image_not_supported_outlined,
          size: Dimensions.veryHuge,
        ),
      ),
      color: Colors.grey,
    );
  }
}
