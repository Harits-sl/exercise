import 'package:exercise/models/course_detail_model.dart';
import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/shared/theme.dart';
import 'package:exercise/ui/pages/detailCourse/detail.dart';
import 'package:exercise/ui/pages/detailCourse/web_view.dart';
import 'package:exercise/ui/pages/materiKelas/materi_kelas_page.dart';
import 'package:exercise/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise/network/api/course_detail_provider.dart';
import './trailer_video.dart';

class DetailCoursePage extends StatelessWidget {
  final int id;
  final String trailerKelas;

  const DetailCoursePage({
    Key? key,
    required this.id,
    required this.trailerKelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);
    var courseDetailProvider = Provider.of<CourseDetailProivder>(context);

    List listCourseId = [];
    List listNamaMateri = [];
    List listVideoMateri = [];
    List listIsDone = [];
    List listIsExpanded = [];
    List l = [];

    void method() {
      CourseDetailModel data = objectDetailProvider.objectDetail;

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
          builder: (context) => MateriKelasPage(
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: courseDetailProvider.getDetail(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // return TrailerVideo(
              //   trailerKelas: trailerKelas,
              //   data: snapshot.data,
              // );

              objectDetailProvider.objectDetail = snapshot.data;

              return Container(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView(
                      children: [
                        appBar(),
                        Container(
                          width: 320,
                          height: 200,
                          padding: EdgeInsets.only(
                            left: defaultMargin,
                            right: defaultMargin,
                            top: defaultMargin,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: WebViews(
                              trailerKelas: trailerKelas,
                            ),
                          ),
                        ),
                        Detail(data: snapshot.data),
                      ],
                    ),
                    CustomButton(
                      title: 'Gabung Kelas',
                      method: method,
                    ),
                  ],
                ),
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
