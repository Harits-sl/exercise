import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function method;

  const CustomButton({
    Key? key,
    required this.title,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (defaultMargin * 2),
      height: 45,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: defaultMargin,
      ),
      child: TextButton(
        onPressed: () {
          method();
        },
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
