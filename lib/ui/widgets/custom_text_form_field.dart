import 'package:exercise/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isObscureText;

  const CustomTextFormField(
      {Key? key,
      required this.title,
      required this.controller,
      this.isObscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textFormField() {
      return Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          color: secondaryButtonColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: TextFormField(
            controller: controller,
            obscureText: isObscureText,
            cursorColor: darkBlueColor,
            style: primaryTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 16,
            ),
            obscuringCharacter: '*',
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                borderSide: BorderSide(
                  color: focusedBorderColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: defaultMargin),
            child: Text(
              title,
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: regular,
              ),
            ),
          ),
          SizedBox(height: 8),
          textFormField(),
        ],
      ),
    );
  }
}
