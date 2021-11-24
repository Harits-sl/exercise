import 'package:exercise/cubit/page/page_cubit.dart';
import 'package:exercise/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarItem extends StatelessWidget {
  final String imageUrl;
  final int index;

  const NavbarItem({
    Key? key,
    required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Container(
        child: Image.asset(
          imageUrl,
          width: 24,
          color:
              context.read<PageCubit>().state == index ? blueColor : greyColor,
        ),
      ),
    );
  }
}
