import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/providers/youtube_id_provider.dart';
import 'package:exercise/theme.dart';

class Materi extends StatefulWidget {
  final List listIsExpanded;
  final List listIsDone;

  const Materi({
    Key? key,
    required this.listIsExpanded,
    required this.listIsDone,
  }) : super(key: key);

  @override
  _MateriState createState() => _MateriState();
}

class _MateriState extends State<Materi> {
  @override
  Widget build(BuildContext context) {
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);

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
          lastStudiedProvider.lastCourse = {
            'id': materi['id'],
            'namaMateri': materi['nama_materi'],
            'imageUrl': objectDetailProvider.objectDetail.thumbnailKelas,
          };
          objectDetailProvider.materi = {
            'id': materi['id'],
            'namaMateri': materi['nama_materi'],
            'videoMateri': materi['video_materi']
          };

          //  youtubeIdProvider.youtubeId = objectDetailProvider
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 12),
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
      int i = -1;
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
