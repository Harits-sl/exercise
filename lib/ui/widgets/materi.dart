import 'package:exercise/cubit/lastStudiedCourse/cubit/last_studied_course_cubit.dart';
import 'package:exercise/cubit/materialCourse/material_course_cubit.dart';
import 'package:exercise/models/course_detail_model.dart';
import 'package:exercise/models/material_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';

class Materi extends StatefulWidget {
  final CourseDetailModel course;
  final List listIsExpanded;
  final List listIsDone;
  final ScrollController scrollController;

  const Materi({
    Key? key,
    required this.course,
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
    Widget _materi(materi, isDone) {
      return BlocBuilder<MaterialCourseCubit, MaterialCourseState>(
        builder: (context, stateMaterial) {
          if (stateMaterial is MaterialCourseSuccess) {
            return BlocBuilder<LastStudiedCourseCubit, LastStudiedCourseState>(
              builder: (context, stateLastStudied) {
                if (stateLastStudied is LastStudiedCourseSuccess) {
                  int searchIndexId = stateLastStudied.course.listId.indexWhere(
                    (id) => id == stateMaterial.data.id,
                  );

                  Map<String, dynamic> theme =
                      stateMaterial.data.id == materi['id']
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

                      context.read<MaterialCourseCubit>().newMapMaterialCourse(
                            id: materi['id'],
                            idMateriBagian: materi['id_bagian_kelas'],
                            idVideoMateri: materi['video_materi'],
                            namaMateri: materi['nama_materi'],
                          );

                      context
                          .read<LastStudiedCourseCubit>()
                          .newMapLastStudiedCourse(
                            index: searchIndexId, //last id yang dipelajari
                            imageUrl: widget.course.thumbnailKelas,
                            namaMateri: materi['nama_materi'],
                            materi: stateLastStudied.course.materi,
                            listId: stateLastStudied.course.listId,
                            listMateri: stateLastStudied.course.listMateri,
                            listIdVideo: stateLastStudied.course.listIdVideo,
                            listIsExpanded: widget.listIsExpanded,
                            listIsDone: widget.listIsDone,
                            listMateriBagian:
                                stateLastStudied.course.listMateriBagian,
                          );
                      // lastStudiedProvider.lastCourse = {
                      //   'namaMateri': materi['nama_materi'],
                      //   'listId': lastCourse['listId'],
                      //   'listMateri': lastCourse['listMateri'],
                      //   'listVideo': lastCourse['listVideo'],
                      //   'listIsExpanded': lastCourse['listIsExpanded'],
                      //   'listIsDone': lastCourse['listIsDone'],
                      //   'materiBagian': lastCourse['materiBagian'],
                      //   'imageUrl': widget.course.thumbnailKelas,
                      //   'index': searchIndexId, //last id yang dipelajari
                      //   'materi': lastStudiedProvider.lastCourse['materi'],
                      // };
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
                return SizedBox();
              },
            );
          }
          return SizedBox();
        },
      );
    }

    Widget listMaterialCourse() {
      int index = -1; // variabel untuk listIsDone

      Widget listTitleMaterial(int indexListViewBagian) {
        return ListView.builder(
          itemCount:
              widget.course.bagian[indexListViewBagian]['materi_kelas'].length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, indexListViewMateriKelas) {
            index += 1;
            return _materi(
              widget.course.bagian[indexListViewBagian]['materi_kelas']
                  [indexListViewMateriKelas],
              widget.listIsDone[index],
            );
          },
        );
      }

      Widget expansionPanelListCourse(int indexListViewBagian) {
        return ExpansionPanelList(
          elevation: 0,
          expansionCallback: (int indexExpansionCallback, bool isExpanded) {
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
                    widget.course.bagian[indexListViewBagian]['nama_bagian'],
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                );
              },
              body: listTitleMaterial(indexListViewBagian),
              isExpanded: widget.listIsExpanded[indexListViewBagian],
            ),
          ],
        );
      }

      return ListView.builder(
        itemCount: widget.course.bagian.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (contex, indexListViewBagian) {
          return expansionPanelListCourse(indexListViewBagian);
        },
      );
    }

    return Container(
      padding: EdgeInsets.only(
        top: defaultMargin,
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          listMaterialCourse(),
        ],
      ),
    );
  }
}
