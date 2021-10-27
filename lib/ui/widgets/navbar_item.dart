import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {
  final String imageUrl;

  const NavbarItem({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imageUrl,
        width: 24,
      ),
    );
  }
}
