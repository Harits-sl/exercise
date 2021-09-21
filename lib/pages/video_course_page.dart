import 'package:exercise/pages/finish_course_page.dart';
import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCoursePage extends StatefulWidget {
  final int id;
  final String videoId;
  final int lastCourseId;
  final List listCourseId;

  const VideoCoursePage(
      {required this.id,
      required this.videoId,
      required this.lastCourseId,
      required this.listCourseId,
      Key? key})
      : super(key: key);

  @override
  _VideoCoursePageState createState() => _VideoCoursePageState(id);
}

class _VideoCoursePageState extends State<VideoCoursePage> {
  int idNow;
  String buttonTitle = 'Next Video';

  _VideoCoursePageState(this.idNow);

  late YoutubePlayerController _controller;
  late String _videoId = widget.videoId;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHD: true,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchIndex = widget.listCourseId.indexWhere(
      (id) => id == idNow,
    );
    var courseProvider = Provider.of<CourseProvider>(context);

    var _getData = courseProvider.getVideoCourseStarter(idNow.toString());
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _getData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              _videoId = data.videoMateri;
              _controller.load(_videoId);

              YoutubePlayer youtubePlayer = YoutubePlayer(
                controller: _controller,
                aspectRatio: 20 / 10,
              );

              return YoutubePlayerBuilder(
                player: youtubePlayer,
                builder: (context, player) {
                  // button next video and finish course
                  ElevatedButton elevatedButton = ElevatedButton(
                    onPressed: () {
                      if (idNow == widget.lastCourseId) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinishCoursePage(),
                          ),
                        );
                      }
                      if (idNow != widget.lastCourseId) {
                        setState(() {
                          idNow = widget.listCourseId[searchIndex + 1];
                        });
                      }
                      setState(() {
                        if (idNow == widget.lastCourseId) {
                          buttonTitle = 'Finish Course';
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 8,
                      ),
                      child: Text(
                        widget.id == widget.lastCourseId
                            ? 'Finish Course'
                            : buttonTitle,
                      ),
                    ),
                  );
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: player,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          data.namaMateri,
                          style: subTitleTextStyle,
                        ),
                        Spacer(),
                        Center(
                          child: elevatedButton,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
