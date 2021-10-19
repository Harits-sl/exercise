import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/theme.dart';

class Materi extends StatefulWidget {
  final List listIsExpanded;
  final List listIsDone;
  final ScrollController scrollController;

  const Materi({
    Key? key,
    required this.listIsExpanded,
    required this.listIsDone,
    required this.scrollController,
  }) : super(key: key);

  @override
  _MateriState createState() => _MateriState();
}

class _MateriState extends State<Materi> {
  @override
  Widget build(BuildContext context) {
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);

    var lastCourse = lastStudiedProvider.lastCourse;
    var searchIndexId = lastCourse['listId'].indexWhere(
      (id) => id == objectDetailProvider.materi['id'],
    );

    Widget _materi(materi, isDone) {
      dynamic theme = objectDetailProvider.materi['id'] == materi['id']
          ? {
              'iconPlay': 'assets/icon_play_active.png',
              'tileColor': darkBlueColor,
              'primaryTextStyle': whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            }
          : {
              'iconPlay': 'assets/icon_play.png',
              'tileColor': whiteColor,
              'primaryTextStyle': primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            };

      return GestureDetector(
        onTap: () {
          widget.scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );

          objectDetailProvider.materi = {
            'id': materi['id'],
            'namaMateri': materi['nama_materi'],
            'videoMateri': materi['video_materi'],
            'idMateriBagian': materi['id_bagian_kelas'],
          };

          lastStudiedProvider.lastCourse = {
            'namaMateri': materi['nama_materi'],
            'listId': lastCourse['listId'],
            'listMateri': lastCourse['listMateri'],
            'listVideo': lastCourse['listVideo'],
            'listIsExpanded': lastCourse['listIsExpanded'],
            'listIsDone': lastCourse['listIsDone'],
            'materiBagian': lastCourse['materiBagian'],
            'imageUrl': objectDetailProvider.objectDetail.thumbnailKelas,
            'index': searchIndexId, //last id yang dipelajari
            'materi': lastStudiedProvider.lastCourse['materi'],
          };
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: 12,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            tileColor: theme['tileColor'],
            leading: Image.asset(
              theme['iconPlay'],
              width: 38,
            ),
            title: Text(
              materi['nama_materi'],
              style: theme['primaryTextStyle'],
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${materi['duration']} Min',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            trailing: isDone
                ? Image.asset(
                    'assets/icon_check_green.png',
                    width: 24,
                  )
                : SizedBox(
                    width: 0,
                  ),
          ),
        ),
      );
    }

    Container newMethod() {
      int i = -1; // index untuk listIsDone
      return Container(
        padding: EdgeInsets.only(
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
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
                          i += 1;
                          return _materi(
                            objectDetailProvider
                                    .objectDetail.bagian[indexListViewBagian]
                                ['materi_kelas'][indexListViewMateriKelas],
                            widget.listIsDone[i],
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

    return newMethod();
  }
}
