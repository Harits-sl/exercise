import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Crashlytics {
  static recordError(Object? err, StackTrace? stackTrace, String reason) {
    FirebaseCrashlytics.instance.recordError(err, stackTrace, reason: reason);
  }
}
