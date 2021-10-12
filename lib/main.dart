import 'package:exercise/pages/splash_screen.dart';
import 'package:exercise/providers/course_starter_provider.dart';
import 'package:exercise/providers/course_detail_provider.dart';
import 'package:exercise/providers/course_video_detail_provider.dart';
import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/providers/search_provider.dart';
import 'package:exercise/providers/youtube_id_provider.dart';
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
        Provider<CourseDetailProivder>(
          create: (context) => CourseDetailProivder(),
        ),
        Provider<YoutubeIdProvider>(
          create: (context) => YoutubeIdProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<LastStudiedProvider>(
          create: (context) => LastStudiedProvider(),
        ),
        ChangeNotifierProvider<ObjectDetailProvider>(
          create: (context) => ObjectDetailProvider(),
        ),
        ChangeNotifierProvider<CourseVideoDetailProvider>(
          create: (context) => CourseVideoDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
