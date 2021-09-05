import 'package:exercise/pages/finish_course_page.dart';
import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/widgets/video_course.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCoursePage extends StatefulWidget {
  final int id;
  final int lastCourseId;
  final List listCourseId;

  const VideoCoursePage(
      {required this.id,
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

  @override
  Widget build(BuildContext context) {
    var searchIndex = widget.listCourseId.indexWhere(
      (id) => id == idNow,
    );
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

                  String videoId = data.videoMateri;
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: YoutubePlayerFlags(
                      forceHD: true,
                    ),
                  );
                  return Column(
                    children: [
                      VideoCourse(
                        videoId: videoId,
                        controller: _controller,
                        namaMateri: data.namaMateri,
                      ),
                      Center(
                        child: ElevatedButton(
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
                        ),
                      ),
                      SizedBox(
                        height: 120,
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
