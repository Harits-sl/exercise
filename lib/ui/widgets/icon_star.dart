import 'package:flutter/material.dart';

class IconStar extends StatelessWidget {
  const IconStar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon_star.png',
          width: 14,
        ),
        SizedBox(
          width: 1,
        ),
        Image.asset(
          'assets/icon_star.png',
          width: 14,
        ),
        SizedBox(
          width: 1,
        ),
        Image.asset(
          'assets/icon_star.png',
          width: 14,
        ),
        SizedBox(
          width: 1,
        ),
        Image.asset(
          'assets/icon_star.png',
          width: 14,
        ),
        SizedBox(
          width: 1,
        ),
        Image.asset(
          'assets/icon_star.png',
          width: 14,
        ),
        SizedBox(
          width: 1,
        ),
      ],
    );
  }
}
