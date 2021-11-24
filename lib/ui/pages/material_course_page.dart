import 'package:exercise/cubit/detailCourse/detail_course_cubit.dart';
import 'package:exercise/cubit/lastStudiedCourse/cubit/last_studied_course_cubit.dart';
import 'package:exercise/cubit/materialCourse/material_course_cubit.dart';
import 'package:exercise/models/course_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// page
import 'finish_course_page.dart';

// widgets
import '../widgets/materi.dart';
import '../widgets/card_tool.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_in_app_web_view.dart';

// theme
import '../../shared/theme.dart';

// helpers
import '../../helpers/string_helper.dart';

class MaterialCoursePage extends StatefulWidget {
  final List listId;
  final List listMateri;
  final List listVideo;
  final List listIsExpanded;
  final List listIsDone;
  final List materiBagian;
  final List materi;
  final int index;

  const MaterialCoursePage({
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
  _MaterialCoursePageState createState() => _MaterialCoursePageState();
}

class _MaterialCoursePageState extends State<MaterialCoursePage> {
  late int index;
  late ScrollController _scrollController;
  double currentScroll = 0;
  int searchIndexId = 0;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    index = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocBuilder<MaterialCourseCubit, MaterialCourseState>(
      builder: (context, state) {
        print('state');
        if (state is MaterialCourseSuccess) {
          print('state.data');
          setState(() {
            searchIndexId = widget.listId.indexWhere(
              (id) => id == state.data.id,
            );
            index = searchIndexId;
          });
        }
        return Text('sssadsdsc');
      },
    );

    /*
      untuk materi bagian
      list idMateriBagian dari data id_bagian_kelas
      contoh : [1,1,2,2,3,3,3,4]
    */
    List idMateriBagian = [];

    /// unik id materi bagian
    List uIdMateriBagian = [];

    /*
    lalukan perulangan dan hanya id bagian kelas dari API melalui widget.materiBagian
    lalu ditampung di variable idMateriBagian
   */
    for (var item in widget.materiBagian) {
      idMateriBagian.add(item['id_bagian_kelas']);
    }

    /// filter id materi bagian yang berbeda dari list idMateriBagian dan ditampung di uIdMateriBagian
    /*
      contoh : [1,1,1,2,2,3,3,4]
      menjadi [1,2,3,4]
     */
    uIdMateriBagian = idMateriBagian.toSet().toList();

    int searchIndexIdBagianMateri(int idMateriBagian) {
      int index = uIdMateriBagian.indexWhere(
        (id) => id == idMateriBagian,
      );
      return index;
    }

    void methodForButton() {
      if (widget.listId.last == widget.listId[searchIndexId]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FinishCoursePage(),
          ),
        );
      }

      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );

      context.read<MaterialCourseCubit>().newMapMaterialCourse(
            id: widget.listId[searchIndexId + 1],
            idMateriBagian: widget.materiBagian[searchIndexId + 1]
                ['id_bagian_kelas'],
            idVideoMateri: widget.listVideo[searchIndexId + 1],
            namaMateri: widget.listMateri[searchIndexId + 1],
          );

      context.read<LastStudiedCourseCubit>().newMapLastStudiedCourse(
            index: searchIndexId + 1, //last id yang dipelajari,
            imageUrl: imageUrl,
            namaMateri: widget.listMateri[searchIndexId + 1],
            materi: widget.materi,
            listId: widget.listId,
            listMateri: widget.listMateri,
            listIdVideo: widget.listVideo,
            listIsExpanded: widget.listIsExpanded,
            listIsDone: widget.listIsDone,
            listMateriBagian: widget.materiBagian,
          );

      setState(() {
        widget.listIsDone[searchIndexId] = true;
      });
    }

    Widget appBar(CourseDetailModel data) {
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
                data.namaKelas,
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
                    StringHelper.toTitleCase(
                      data.authors[0]['name'],
                    ),
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
        child: BlocBuilder<MaterialCourseCubit, MaterialCourseState>(
          builder: (context, state) {
            if (state is MaterialCourseSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.data.namaMateri,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  // Text(
                  //   objectDetailProvider.materi['namaMateri'],
                  //   style: primaryTextStyle.copyWith(
                  //     fontSize: 16,
                  //     fontWeight: semiBold,
                  //   ),
                  // ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Materi bagian: ${widget.materi[searchIndexIdBagianMateri(state.data.idMateriBagian)]['nama_bagian']}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  // Text(
                  //   'Materi bagian: ${widget.materi[searchIndexIdBagianMateri()]['nama_bagian']}',
                  //   style: primaryTextStyle.copyWith(
                  //     fontSize: 12,
                  //     fontWeight: regular,
                  //   ),
                  // ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      );
    }

    Widget toolKelas(tools) {
      return tools.length != 0
          ? Container(
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
                      itemCount: tools.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: index == 0 ? defaultMargin : 12,
                            ),
                            CardTool(
                              tools: tools[index],
                            ),
                            SizedBox(
                              width:
                                  index == tools.length - 1 ? defaultMargin : 0,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container();
    }

    Widget videoMateri() {
      return Container(
        width: 320,
        height: 200,
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CustomInAppWebView(
            trailerKelas: widget.listVideo[index],
            key: UniqueKey(),
          ),
        ),
      );
    }

    Widget body() {
      List listCourseId = [];
      List listNamaMateri = [];
      List listVideoMateri = [];
      List listIsDone = [];
      List listIsExpanded = [];
      List l = [];

      void method(CourseDetailModel course) {
        CourseDetailModel data = course;

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
      }

      return BlocBuilder<DetailCourseCubit, DetailCourseState>(
        builder: (context, state) {
          if (state is DetailCourseLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailCourseSuccess) {
            method(state.course);

            return BlocBuilder<MaterialCourseCubit, MaterialCourseState>(
              builder: (context, data) {
                if (data is MaterialCourseSuccess) {
                  searchIndexId = widget.listId.indexWhere(
                    (id) => id == data.data.id,
                  );
                  index = searchIndexId;
                  imageUrl = state.course.thumbnailKelas;

                  return SafeArea(
                    child: Stack(
                      children: [
                        ListView(
                          controller: _scrollController,
                          children: [
                            appBar(state.course),
                            header(),
                            videoMateri(),
                            Materi(
                              course: state.course,
                              listIsExpanded: widget.listIsExpanded,
                              listIsDone: widget.listIsDone,
                              scrollController: _scrollController,
                            ),
                            toolKelas(state.course.tools),
                          ],
                        ),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: CustomButton(
                            title: 'Tandakan Selesai & Next Video',
                            method: methodForButton,
                            borderRadius: 14,
                            color: blueColor,
                            marginBottom: defaultMargin,
                            textStyle: whiteTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            );
          }
          return SizedBox();
        },
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: body(),
    );
  }
}
