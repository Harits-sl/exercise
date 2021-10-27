import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CardTool extends StatelessWidget {
  final tools;
  const CardTool({
    Key? key,
    required this.tools,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://buildwithangga.com${tools['image']}',
                width: 42,
                height: 42,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                tools['name'],
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              // Text(
              //   'Tools Design',
              //   style: secondaryTextStyle.copyWith(
              //     fontWeight: medium,
              //     fontSize: 10,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
