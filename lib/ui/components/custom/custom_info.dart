import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomInfo extends StatelessWidget {
  final String infoText;
  final String? infoDescription;
  final Widget widget;

  const CustomInfo(
      {required this.widget,
      required this.infoText,
      this.infoDescription,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimensions.huge,
        left: Dimensions.veryHuge,
        right: Dimensions.veryHuge,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            const SizedBox(height: Dimensions.huge),
            Text(
              infoText,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimensions.basic),
            if (infoDescription?.isNotEmpty ?? false)
              Text(
                infoDescription!,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
