import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCourse extends StatefulWidget {
  final String videoId;
  final String namaMateri;
  final dynamic controller;
  const VideoCourse(
      {required this.videoId,
      required this.namaMateri,
      this.controller,
      Key? key})
      : super(key: key);

  @override
  _VideoCourseState createState() => _VideoCourseState(controller);
}

class _VideoCourseState extends State<VideoCourse> {
  dynamic _controller;
  _VideoCourseState(this._controller);

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _controller.load(widget.videoId);

    return YoutubePlayerBuilder(
      // onEnterFullScreen: () {
      //   SystemChrome.setPreferredOrientations([
      //     DeviceOrientation.landscapeLeft,
      //     DeviceOrientation.landscapeRight
      //   ]);
      // },
      // onExitFullScreen: () {
      //   SystemChrome.setPreferredOrientations([
      //     DeviceOrientation.portraitUp,
      //   ]);
      // },
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
      builder: (context, player) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: player,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.namaMateri,
                style: subTitleTextStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
