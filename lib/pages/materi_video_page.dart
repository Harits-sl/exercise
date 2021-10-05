import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise/pages/finish_course_page.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/card_tool.dart';
import 'package:exercise/widgets/materi.dart';
import 'package:exercise/widgets/video_course.dart';

class MateriVideoPage extends StatefulWidget {
  final List listId;
  final List listMateri;
  final List listVideo;
  final List listIsExpanded;
  final List listIsDone;
  final String materiBagian;

  const MateriVideoPage({
    Key? key,
    required this.listId,
    required this.listMateri,
    required this.listVideo,
    required this.listIsExpanded,
    required this.listIsDone,
    required this.materiBagian,
  }) : super(key: key);

  @override
  _MateriVideoPageState createState() => _MateriVideoPageState();
}

class _MateriVideoPageState extends State<MateriVideoPage> {
  @override
  Widget build(BuildContext context) {
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);

    Widget appBar() {
      return Container(
        color: blueColor,
        height: 137,
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
              'Materi bagian: ${widget.materiBagian}',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
          ],
        ),
      );
    }

    Widget videoPlayer(String youtubeId) {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: VideoCourse(youtubeId: youtubeId),
        ),
      );
    }

    Widget materiKelas() {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            ListView.builder(
              itemCount: objectDetailProvider.objectDetail.bagian.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (contex, indexListViewBagian) {
                return ExpansionPanelList(
                  elevation: 0,
                  expansionCallback:
                      (int indexExpansionCallback, bool isExpanded) {
                    setState(() {
                      widget.listIsExpanded[indexListViewBagian] = !isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor: backgroundColor,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            objectDetailProvider.objectDetail
                                .bagian[indexListViewBagian]['nama_bagian'],
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        );
                      },
                      body: ListView.builder(
                        itemCount: objectDetailProvider.objectDetail
                            .bagian[indexListViewBagian]['materi_kelas'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexListViewMateriKelas) {
                          return Materi(
                            materi: objectDetailProvider
                                    .objectDetail.bagian[indexListViewBagian]
                                ['materi_kelas'][indexListViewMateriKelas],
                            isDone: widget.listIsDone[indexListViewMateriKelas],
                          );
                        },
                      ),
                      isExpanded: widget.listIsExpanded[indexListViewBagian],
                    ),
                  ],
                );
              },
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
            if (widget.listId.last == objectDetailProvider.materi['id']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FinishCoursePage(),
                ),
              );
            }

            var searchIndex = widget.listId.indexWhere(
              (id) => id == objectDetailProvider.materi['id'],
            );

            objectDetailProvider.materi = {
              'id': widget.listId[searchIndex + 1],
              'namaMateri': widget.listMateri[searchIndex + 1],
              'videoMateri': widget.listVideo[searchIndex + 1],
            };

            setState(() {
              widget.listIsDone[searchIndex] = true;
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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        // ketika device landscape
        // hanya mengembalikan youtube video player
        if (orientation == Orientation.landscape) {
          return videoPlayer(objectDetailProvider.objectDetail.bagian[0]
              ['materi_kelas'][0]['video_materi']);
        } else {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: ListView(
                children: [
                  appBar(),
                  header(),
                  videoPlayer(objectDetailProvider.objectDetail.bagian[0]
                      ['materi_kelas'][0]['video_materi']),
                  materiKelas(),
                  toolKelas(),
                ],
              ),
            ),
            floatingActionButton: floatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
    // return Scaffold(
    //   backgroundColor: backgroundColor,
    //   body: SafeArea(
    //     child: ListView(
    //       children: [
    //         appBar(),
    //         header(),
    //         videoPlayer(objectDetailProvider.objectDetail.bagian[0]
    //             ['materi_kelas'][0]['video_materi']),
    //         materiKelas(),
    //         toolKelas(),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: floatingActionButton(),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // );
  }
}
