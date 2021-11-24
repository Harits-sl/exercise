import 'package:exercise/cubit/page/page_cubit.dart';
import 'package:exercise/shared/theme.dart';
import 'package:exercise/ui/pages/profile_page.dart';
import 'package:exercise/ui/widgets/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homePage/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 3:
          return ProfilePage();
        default:
          return HomePage();
      }
    }

    Widget navbar() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: whiteColor,
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavbarItem(
                index: 0,
                imageUrl: 'assets/icon_home.png',
              ),
              NavbarItem(
                index: 1,
                imageUrl: 'assets/icon_explore.png',
              ),
              NavbarItem(
                index: 2,
                imageUrl: 'assets/icon_cart.png',
              ),
              NavbarItem(
                index: 3,
                imageUrl: 'assets/icon_setting.png',
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              navbar(),
            ],
          ),
        );
      },
    );
  }
}
