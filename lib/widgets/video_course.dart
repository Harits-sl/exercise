import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';
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
  dynamic controller;
  _VideoCourseState(this.controller);

  @override
  Widget build(BuildContext context) {
    controller.load(widget.videoId);
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
      ),
      builder: (context, player) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              player,
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
