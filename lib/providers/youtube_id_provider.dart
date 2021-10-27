import 'package:flutter/material.dart';

class YoutubeIdProvider with ChangeNotifier {
  var _youtubeId;

  String get youtubeId => _youtubeId;

  set youtubeId(String newYoutubeId) {
    _youtubeId = newYoutubeId;
    notifyListeners();
  }
}
