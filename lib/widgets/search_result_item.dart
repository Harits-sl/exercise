import 'package:exercise/theme.dart';
import 'package:exercise/utils/add_comma.dart';
import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconStar() {
      return Row(
        children: [
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

    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      padding: EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 12,
        right: 15,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/latest_course.png',
              width: 62,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/profile_blank.png',
                      width: 13,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Angga Risky',
                      style: secondaryTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Full-Stack Laravel Flutter 2021: Building E-Commerce and Chat Apps',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconStar(),
                    iconStar(),
                    iconStar(),
                    iconStar(),
                    iconStar(),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '222.22',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
