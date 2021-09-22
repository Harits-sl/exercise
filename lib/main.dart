import 'package:exercise/pages/splash_screen.dart';
import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/providers/course_starter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CourseStarterProvider>(
          create: (context) => CourseStarterProvider(),
        ),
        // NOTE: provider lama
        Provider<CourseProvider>(
          create: (context) => CourseProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
