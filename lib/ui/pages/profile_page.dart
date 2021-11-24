import 'package:exercise/cubit/user/user_cubit.dart';
import 'package:exercise/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUser();

    Widget header() {
      void onPressed() {
        // hapus data user dari database lokal
        context.read<UserCubit>().removeUser();

        // navigasi ke halaman login
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }

      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            return Container(
              width: double.infinity,
              height: 105,
              color: whiteColor,
              padding: EdgeInsets.all(defaultMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://bwasandbox.com${state.user.avatar}',
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.user.name,
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'UI Designer',
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      onPressed: onPressed,
                      child: Text(
                        'Keluar',
                        style: redTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    Widget content() {
      Widget category() {
        return Container(
          // width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: backgroundColor,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: darkBlueColor,
                ),
                child: Text(
                  'My Library',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(width: 9),
              Container(
                child: Text(
                  'My Library',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        // width: double.infinity,
        // height: double.infinity,
        color: whiteColor,
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        margin: EdgeInsets.only(top: 14),
        child: category(),
      );
    }

    Widget body() {
      return SafeArea(
        child: Column(
          children: [
            header(),
            // content(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: body(),
    );
  }
}
