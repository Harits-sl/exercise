import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:exercise/models/course_detail_model.dart';
import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/providers/object_detail.dart';

import './detail.dart';
import '../materi_video_page.dart';
import '../../widgets/custom_button.dart';
import '../../../shared/theme.dart';

class TrailerVideo extends StatefulWidget {
  final String trailerKelas;
  final CourseDetailModel data;
  const TrailerVideo({
    required this.trailerKelas,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  _TrailerVideoState createState() => _TrailerVideoState();
}

class _TrailerVideoState extends State<TrailerVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerKelas,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
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
    CourseDetailModel data = widget.data;
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);

    List listCourseId = [];
    List listNamaMateri = [];
    List listVideoMateri = [];
    List listIsDone = [];
    List listIsExpanded = [];
    List l = [];

    void method() {
      objectDetailProvider.objectDetail = data;

      void _addListId(value) {
        listCourseId.add(value);
      }

      void _addListMateri(value) {
        listNamaMateri.add(value);
      }

      void _addListVideo(value) {
        listVideoMateri.add(value);
      }

      void b(value) {
        l.add(value);
      }

      void _addListExpanded(value) {
        listIsExpanded.add(value);
      }

      void _addListDone(value) {
        listIsDone.add(value);
      }

      var id = data.bagian.map((item) => item).map((item) {
        for (var i = 0; i < item['materi_kelas'].length; i++) {
          _addListId(item['materi_kelas'][i]['id']);
        }
      });

      var namaMateri = data.bagian.map((item) => item).map((item) {
        for (var i = 0; i < item['materi_kelas'].length; i++) {
          _addListMateri(item['materi_kelas'][i]['nama_materi']);
        }
      });

      var videoMateri = data.bagian.map((item) => item).map((item) {
        for (var i = 0; i < item['materi_kelas'].length; i++) {
          _addListVideo(item['materi_kelas'][i]['video_materi']);
        }
      });

      var a = data.bagian.map((item) => item).map((item) {
        for (var i = 0; i < item['materi_kelas'].length; i++) {
          b(item['materi_kelas'][i]);
        }
      });
      print(a);
      print(id);
      print(namaMateri);
      print(videoMateri);

      for (var i = 0; i < data.bagian.length; i++) {
        _addListExpanded(true);
      }

      for (var i = 0; i < listCourseId.length; i++) {
        _addListDone(false);
      }

      objectDetailProvider.materi = {
        'id': listCourseId.first,
        'idMateriBagian': data.bagian[0]['materi_kelas'][0]['id_bagian_kelas'],
        'namaMateri': listNamaMateri.first,
        'videoMateri': listVideoMateri.first,
      };

      lastStudiedProvider.lastCourse = {
        'namaMateri': listNamaMateri.first,
        'listId': listCourseId,
        'listMateri': listNamaMateri,
        'listVideo': listVideoMateri,
        'listIsExpanded': listIsExpanded,
        'listIsDone': listIsDone,
        'materiBagian': l,
        'imageUrl': data.thumbnailKelas,
        'index': 0,
        'materi': data.bagian,
      };

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MateriVideoPage(
            listId: listCourseId,
            listMateri: listNamaMateri,
            listVideo: listVideoMateri,
            listIsExpanded: listIsExpanded,
            listIsDone: listIsDone,
            materiBagian: l,
            materi: data.bagian,
            index: 0,
          ),
        ),
      );
    }

    Widget appBar() {
      return Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
            Text(
              'Detail Course',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 24,
            ),
          ],
        ),
      );
    }

    YoutubePlayer youtubePlayer = YoutubePlayer(
      controller: _controller,
      // aspect ratio ketika landscape
      aspectRatio: 19 / 9,
    );

    return YoutubePlayerBuilder(
      player: youtubePlayer,
      builder: (context, player) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    appBar(),
                    Container(
                      padding: EdgeInsets.only(
                        left: defaultMargin,
                        right: defaultMargin,
                        top: defaultMargin,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: player,
                        ),
                      ),
                    ),
                    Detail(data: widget.data),
                  ],
                ),
              ),
            ),
            CustomButton(title: 'Gabung Kelas', method: method),
          ],
        );
      },
    );
  }
}
