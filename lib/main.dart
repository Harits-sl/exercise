import 'dart:async';
import 'dart:isolate';

import 'package:exercise/cubit/auth/auth_cubit.dart';
import 'package:exercise/cubit/authGoogle/auth_google_cubit.dart';
import 'package:exercise/cubit/detailCourse/detail_course_cubit.dart';
import 'package:exercise/cubit/lastStudiedCourse/cubit/last_studied_course_cubit.dart';
import 'package:exercise/cubit/materialCourse/material_course_cubit.dart';
import 'package:exercise/cubit/page/page_cubit.dart';
import 'package:exercise/cubit/search/search_cubit.dart';
import 'package:exercise/cubit/searchCourse/search_course_cubit.dart';
import 'package:exercise/cubit/starterCourse/starter_course_cubit.dart';
import 'package:exercise/cubit/user/user_cubit.dart';
import 'package:exercise/ui/pages/login_page.dart';
import 'package:exercise/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// page
import './ui/pages/splash_page.dart';

// helper
import './helpers/certificate_helpers.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    certificateHelpers();
    runApp(const MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AuthGoogleCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => FreeStarterCourseCubit(),
        ),
        BlocProvider(
          create: (context) => TopStarterCourseCubit(),
        ),
        BlocProvider(
          create: (context) => FreeStarterCourseForHomeCubit(),
        ),
        BlocProvider(
          create: (context) => TopStarterCourseForHomeCubit(),
        ),
        BlocProvider(
          create: (context) => LastStudiedCourseCubit(),
        ),
        BlocProvider(
          create: (context) => DetailCourseCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCourseCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => MaterialCourseCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
