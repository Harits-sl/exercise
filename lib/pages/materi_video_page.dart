import 'dart:async';

import 'package:exercise/providers/last_studied_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:exercise/pages/finish_course_page.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/card_tool.dart';
import 'package:exercise/widgets/materi.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MateriVideoPage extends StatefulWidget {
  final List listId;
  final List listMateri;
  final List listVideo;
  final List listIsExpanded;
  final List listIsDone;
  final List materiBagian;
  final List materi;
  final int index;

  const MateriVideoPage({
    Key? key,
    required this.listId,
    required this.listMateri,
    required this.listVideo,
    required this.listIsExpanded,
    required this.listIsDone,
    required this.materiBagian,
    required this.materi,
    required this.index,
  }) : super(key: key);

  @override
  _MateriVideoPageState createState() => _MateriVideoPageState();
}

class _MateriVideoPageState extends State<MateriVideoPage> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late ScrollController _scrollController;
  double currentScroll = 0;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(() {});

    _controller = YoutubePlayerController(
      initialVideoId: widget.listVideo[widget.index],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);

    YoutubePlayer youtubePlayer = YoutubePlayer(
      controller: _controller,
      // aspect ratio ketika landscape
      aspectRatio: 19 / 9,
    );

    // ketika button next materi atau materi di klik
    // jika position dibawah, setstate selama 0.5 detik
    // jika posisition paling atas, tunggu 1 detik lalu
    // load video baru
    if (_scrollController.hasClients) {
      void scroll(double position) {
        if (position > 0) {
          setState(() {
            currentScroll = _scrollController.offset;
          });
          Timer(Duration(milliseconds: 500), () {
            scroll(currentScroll);
          });
        }
        if (position == 0) {
          Timer(Duration(milliseconds: 1000), () {
            _controller.load(objectDetailProvider.materi['videoMateri']);
          });
          return;
        }
      }

      scroll(_scrollController.offset);
    }

    // untuk materi bagian
    // list idMateriBagian dari data id_bagian_kelas
    // [1,1,2,2,3,3,3,4]
    List idMateriBagian = [];
    for (var item in widget.materiBagian) {
      idMateriBagian.add(item['id_bagian_kelas']);
    }
    // hanya menampilkan id yang berbeda [1,2,3,4]
    List idUnikMateriBagian = idMateriBagian.toSet().toList();

    int searchIndexIdBagianMateri() {
      int index = idUnikMateriBagian.indexWhere(
        (id) => id == objectDetailProvider.materi['idMateriBagian'],
      );
      return index;
    }

    Widget appBar() {
      return Container(
        color: blueColor,
        constraints: BoxConstraints(
          minHeight: 137,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 74,
            vertical: defaultMargin,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                objectDetailProvider.objectDetail.namaKelas,
                style: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/profile_white.png',
                    width: 13,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    objectDetailProvider.objectDetail.authors[0]['name'],
                    style: whiteTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget header() {
      return Container(
        padding: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              objectDetailProvider.materi['namaMateri'],
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Materi bagian: ${widget.materi[searchIndexIdBagianMateri()]['nama_bagian']}',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
          ],
        ),
      );
    }

    Widget floatingActionButton() {
      return SizedBox(
        width: MediaQuery.of(context).size.width - (defaultMargin * 2),
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );

            if (widget.listId.last == objectDetailProvider.materi['id']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FinishCoursePage(),
                ),
              );
            }

            var searchIndexId = widget.listId.indexWhere(
              (id) => id == objectDetailProvider.materi['id'],
            );

            lastStudiedProvider.lastCourse = {
              'namaMateri': widget.listMateri[searchIndexId + 1],
              'listId': widget.listId,
              'listMateri': widget.listMateri,
              'listVideo': widget.listVideo,
              'listIsExpanded': widget.listIsExpanded,
              'listIsDone': widget.listIsDone,
              'materiBagian': widget.materiBagian,
              'imageUrl': objectDetailProvider.objectDetail.thumbnailKelas,
              'index': searchIndexId + 1, //last id yang dipelajari
              'materi': widget.materi,
            };
            objectDetailProvider.materi = {
              'id': widget.listId[searchIndexId + 1],
              'namaMateri': widget.listMateri[searchIndexId + 1],
              'videoMateri': widget.listVideo[searchIndexId + 1],
              'listIdMateriBagian': idMateriBagian,
              'idMateriBagian': widget.materiBagian[searchIndexId + 1]
                  ['id_bagian_kelas'],
            };

            setState(() {
              widget.listIsDone[searchIndexId] = true;
            });
          },
          elevation: 0,
          label: Text(
            'Tandakan Selesai & Next Video',
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 14,
            ),
          ),
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
      );
    }

    Widget toolKelas() {
      return Container(
        padding: EdgeInsets.only(
          top: defaultMargin,
          bottom: defaultMargin + 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: defaultMargin,
              ),
              child: Text(
                'Tools Kelas',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 135,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: objectDetailProvider.objectDetail.tools.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: index == 0 ? defaultMargin : 12,
                      ),
                      CardTool(
                        tools: objectDetailProvider.objectDetail.tools[index],
                      ),
                      SizedBox(
                        width: index ==
                                objectDetailProvider.objectDetail.tools.length -
                                    1
                            ? defaultMargin
                            : 0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonNextVideo() {
      return Container(
        width: MediaQuery.of(context).size.width - (defaultMargin * 2),
        height: 45,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        margin: EdgeInsets.only(
          bottom: defaultMargin,
        ),
        child: TextButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );

            if (widget.listId.last == objectDetailProvider.materi['id']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FinishCoursePage(),
                ),
              );
            }

            var searchIndexId = widget.listId.indexWhere(
              (id) => id == objectDetailProvider.materi['id'],
            );

            lastStudiedProvider.lastCourse = {
              'namaMateri': widget.listMateri[searchIndexId + 1],
              'listId': widget.listId,
              'listMateri': widget.listMateri,
              'listVideo': widget.listVideo,
              'listIsExpanded': widget.listIsExpanded,
              'listIsDone': widget.listIsDone,
              'materiBagian': widget.materiBagian,
              'imageUrl': objectDetailProvider.objectDetail.thumbnailKelas,
              'index': searchIndexId + 1, //last id yang dipelajari
              'materi': widget.materi,
            };
            objectDetailProvider.materi = {
              'id': widget.listId[searchIndexId + 1],
              'namaMateri': widget.listMateri[searchIndexId + 1],
              'videoMateri': widget.listVideo[searchIndexId + 1],
              'listIdMateriBagian': idMateriBagian,
              'idMateriBagian': widget.materiBagian[searchIndexId + 1]
                  ['id_bagian_kelas'],
            };

            setState(() {
              widget.listIsDone[searchIndexId] = true;
            });
          },
          child: Text(
            'Tandakan Selesai & Next Video',
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return YoutubePlayerBuilder(
      player: youtubePlayer,
      builder: (context, player) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                ListView(
                  controller: _scrollController,
                  children: [
                    appBar(),
                    header(),
                    Container(
                      padding: EdgeInsets.only(
                        left: defaultMargin,
                        right: defaultMargin,
                        top: 12,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: player,
                        ),
                      ),
                    ),
                    Materi(
                      listIsExpanded: widget.listIsExpanded,
                      listIsDone: widget.listIsDone,
                      scrollController: _scrollController,
                    ),
                    toolKelas(),
                  ],
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: buttonNextVideo(),
                ),
              ],
            ),
          ),
          // floatingActionButton: floatingActionButton(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
