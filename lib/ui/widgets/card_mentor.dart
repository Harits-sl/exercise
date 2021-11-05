import 'package:exercise/helpers/string_helper.dart';
import 'package:flutter/material.dart';

import './icon_star.dart';
import '../../shared/theme.dart';

class CardMentor extends StatelessWidget {
  final Map author;

  const CardMentor({
    Key? key,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 151,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Image.network(
              'https://buildwithangga.com${author['avatar']}',
              width: 42,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            StringHelper.toTitleCase(author['name']),
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
            ),
          ),
          // SizedBox(
          //   height: 4,
          // ),
          // Text(
          //   'Product Designer',
          //   style: secondaryTextStyle.copyWith(
          //     fontWeight: regular,
          //     fontSize: 12,
          //   ),
          // ),
          SizedBox(
            height: 4,
          ),
          IconStar(),
          SizedBox(
            height: 16,
          ),
          Text(
            'Profile Mentor',
            style: blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
