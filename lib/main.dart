import 'dart:async';
import 'dart:isolate';
import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/helpers/certificate_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// api
import './network/api/course_starter_provider.dart';
import './network/api/course_detail_provider.dart';
import './network/api/course_video_detail_provider.dart';
import './network/api/course_search_provider.dart';

// provider
import './providers/search_provider.dart';
import './providers/last_studied_provider.dart';
import './providers/object_detail.dart';

// page
import './ui/pages/splash_page.dart';

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
    return MultiProvider(
      providers: [
        // api
        ChangeNotifierProvider<CourseStarterProvider>(
          create: (context) => CourseStarterProvider(),
        ),
        ChangeNotifierProvider<CourseDetailProivder>(
          create: (context) => CourseDetailProivder(),
        ),
        ChangeNotifierProvider<CourseSearchProvider>(
          create: (context) => CourseSearchProvider(),
        ),
        ChangeNotifierProvider<CourseVideoDetailProvider>(
          create: (context) => CourseVideoDetailProvider(),
        ),

        // provider
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<LastStudiedProvider>(
          create: (context) => LastStudiedProvider(),
        ),
        ChangeNotifierProvider<ObjectDetailProvider>(
          create: (context) => ObjectDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
