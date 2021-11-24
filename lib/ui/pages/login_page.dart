import 'package:exercise/cubit/auth/auth_cubit.dart';
import 'package:exercise/cubit/authGoogle/auth_google_cubit.dart';
import 'package:exercise/repository/database/user_db.dart';
import 'package:exercise/shared/theme.dart';
import 'package:exercise/ui/widgets/custom_button.dart';
import 'package:exercise/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Center(
          child: Image.asset(
            'assets/logo_bwa.png',
            width: 56,
            height: 56,
          ),
        ),
      );
    }

    Widget containerLogin() {
      Widget title() {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 4,
            left: defaultMargin,
          ),
          child: Text(
            'Let’s Begin',
            style: primaryTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
        );
      }

      Widget inputEmail() {
        return CustomTextFormField(
          title: 'Email address',
          controller: emailController,
        );
      }

      Widget inputPassword() {
        return CustomTextFormField(
          title: 'Password',
          controller: passwordController,
          isObscureText: true,
        );
      }

      Widget forgetPassword() {
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
            right: defaultMargin,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              'Lupa Password?',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
          ),
        );
      }

      Widget buttonSignIn() {
        void method() {
          // hanya untuk debug
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   '/main',
          //   (route) => false,
          // );

          // NOTE: uncomment ini untuk release
          context.read<AuthCubit>().signIn(
                email: emailController.text,
                password: passwordController.text,
              );
        }

        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // save data user ke database lokal
              UserDB.saveUser(state.auth.data);

              // navigasi ke halaman main
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/main',
                (route) => false,
              );
            }
            // else if (state is AuthFailed) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       backgroundColor: Colors.red,
            //       content: Text(state.error),
            //     ),
            //   );
            // }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: CustomButton(
                title: 'Sign In',
                method: method,
                borderRadius: 100,
                color: blueColor,
                textStyle: whiteTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            );
          },
        );
      }

      Widget buttonGoogleSignIn() {
        void method() {
          context.read<AuthGoogleCubit>().oAuthGoogleSignIn();
        }

        return BlocConsumer<AuthGoogleCubit, AuthGoogleState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // save data user ke database lokal
              // UserDB.saveUser(state.auth.data);

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/main',
                (route) => false,
              );
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(''),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: CustomButton(
                title: 'Masuk Dengan Google',
                method: method,
                borderRadius: 100,
                color: darkBlueColor,
                imageUrl: 'assets/logo_google.png',
                textStyle: whiteTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            );
          },
        );
      }

      Widget divider() {
        return Container(
          margin: EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Divider(
            color: secondaryButtonColor,
            thickness: 1,
          ),
        );
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: defaultMargin),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(),
            inputEmail(),
            inputPassword(),
            // forgetPassword(),
            buttonSignIn(),
            divider(),
            buttonGoogleSignIn(),
          ],
        ),
      );
    }

    Widget body() {
      return SafeArea(
        bottom: false,
        child: ListView(
          children: [
            logo(),
            containerLogin(),
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
