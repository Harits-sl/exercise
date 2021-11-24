import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String title;
  final String? imageUrl;
  final Function method;
  final double marginTop;
  final double marginBottom;
  final double borderRadius;
  final TextStyle textStyle;

  const CustomButton({
    Key? key,
    required this.color,
    required this.title,
    required this.method,
    required this.textStyle,
    required this.borderRadius,
    this.imageUrl,
    this.marginTop = 0,
    this.marginBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (defaultMargin * 2),
      height: 45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      margin: EdgeInsets.only(
        top: marginTop,
        bottom: marginBottom,
      ),
      child: TextButton(
        onPressed: () {
          method();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl != null
                ? Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/logo_google.png',
                      width: 24,
                    ),
                  )
                : Container(),
            Text(
              title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
