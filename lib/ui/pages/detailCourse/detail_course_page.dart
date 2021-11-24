import 'package:exercise/cubit/detailCourse/detail_course_cubit.dart';
import 'package:exercise/cubit/lastStudiedCourse/cubit/last_studied_course_cubit.dart';
import 'package:exercise/cubit/materialCourse/material_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// pages
import './detail.dart';
import '../material_course_page.dart';

// theme
import '../../../shared/theme.dart';

// widgets
import '../../widgets/custom_in_app_web_view.dart';
import '../../widgets/custom_button.dart';

// models
import '../../../models/course_detail_model.dart';

class DetailCoursePage extends StatefulWidget {
  final int id;

  const DetailCoursePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetailCoursePageState createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  @override
  void initState() {
    context.read<DetailCourseCubit>().getDetailCourse(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    this.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List listCourseId = [];
    List listNamaMateri = [];
    List listVideoMateri = [];
    List listIsDone = [];
    List listIsExpanded = [];
    List l = [];

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

    Widget body() {
      return SafeArea(
        child: BlocBuilder<DetailCourseCubit, DetailCourseState>(
          builder: (context, state) {
            if (state is DetailCourseLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is DetailCourseSuccess) {
              void method() {
                CourseDetailModel data = state.course;

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

                context.read<MaterialCourseCubit>().newMapMaterialCourse(
                      id: listCourseId.first,
                      idMateriBagian: data.bagian[0]['materi_kelas'][0]
                          ['id_bagian_kelas'],
                      idVideoMateri: listVideoMateri.first,
                      namaMateri: listNamaMateri.first,
                    );

                context.read<LastStudiedCourseCubit>().newMapLastStudiedCourse(
                      index: 0,
                      imageUrl: data.thumbnailKelas,
                      namaMateri: listNamaMateri.first,
                      materi: data.bagian,
                      listId: listCourseId,
                      listMateri: listNamaMateri,
                      listIdVideo: listVideoMateri,
                      listIsExpanded: listIsExpanded,
                      listIsDone: listIsDone,
                      listMateriBagian: l,
                    );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialCoursePage(
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

              Widget videoPlayer() {
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
                      trailerKelas: state.course.trailerKelas,
                    ),
                  ),
                );
              }

              return Container(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView(
                      children: [
                        appBar(),
                        videoPlayer(),
                        Detail(data: state.course),
                      ],
                    ),
                    CustomButton(
                      title: 'Gabung Kelas',
                      method: method,
                      borderRadius: 14,
                      color: blueColor,
                      marginBottom: defaultMargin,
                      textStyle: whiteTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: body(),
    );
  }
}
