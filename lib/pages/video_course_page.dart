import 'dart:async';

import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/video_course.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCoursePage extends StatefulWidget {
  final int id;

  const VideoCoursePage({required this.id, Key? key}) : super(key: key);

  @override
  _VideoCoursePageState createState() => _VideoCoursePageState(id);
}

class _VideoCoursePageState extends State<VideoCoursePage> {
  int idNow;

  _VideoCoursePageState(this.idNow);

  @override
  Widget build(BuildContext context) {
    var courseProvider = Provider.of<CourseProvider>(context);

    var _getData = courseProvider.getVideoCourseStarter(idNow.toString());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: _getData,
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
              ) {
                if (snapshot.hasData) {
                  var data = snapshot.data;

                  // return YoutubePlayerBuilder(
                  //   player: YoutubePlayer(
                  //     controller: _controller,
                  //   ),
                  //   builder: (context, player) {
                  //     return Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 15),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           player,
                  //           SizedBox(
                  //             height: 12,
                  //           ),
                  //           Text(
                  //             data.namaMateri,
                  //             style: subTitleTextStyle,
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // );
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId: data.videoMateri,
                  );
                  return Column(
                    children: [
                      VideoCourse(
                        controller: _controller,
                        namaMateri: data.namaMateri,
                      ),
                      SizedBox(
                        height: 250,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              idNow += 1;
                            });
                            _controller.load(data.videoMateri);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 8,
                            ),
                            child: Text('Next Video'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
