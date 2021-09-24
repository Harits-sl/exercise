import 'package:flutter/material.dart';

import 'package:exercise/theme.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int totalCouse;

  const CategoryItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.totalCouse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            width: 42,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            name,
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            '$totalCouse Total Course',
            style: secondaryTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
