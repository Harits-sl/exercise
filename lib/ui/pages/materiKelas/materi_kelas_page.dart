import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provider
import '../../../providers/last_studied_provider.dart';
import '../../../providers/object_detail.dart';

// page
import '../finish_course_page.dart';

// widgets
import '../../widgets/materi.dart';
import '../../widgets/card_tool.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_in_app_web_view.dart';

// theme
import '../../../shared/theme.dart';

// helpers
import '../../../helpers/string_helper.dart';

class MateriKelasPage extends StatefulWidget {
  final List listId;
  final List listMateri;
  final List listVideo;
  final List listIsExpanded;
  final List listIsDone;
  final List materiBagian;
  final List materi;
  final int index;

  const MateriKelasPage({
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
  _MateriKelasPageState createState() => _MateriKelasPageState();
}

class _MateriKelasPageState extends State<MateriKelasPage> {
  late int index;
  late ScrollController _scrollController;
  double currentScroll = 0;

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
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);

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

    var searchIndexId = widget.listId.indexWhere(
      (id) => id == objectDetailProvider.materi['id'],
    );

    setState(() {
      index = searchIndexId;
    });

    void methodForButton() {
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
                    StringHelper.toTitleCase(
                      objectDetailProvider.objectDetail.authors[0]['name'],
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

    Widget toolKelas() {
      return objectDetailProvider.objectDetail.tools.length != 0
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
                      itemCount: objectDetailProvider.objectDetail.tools.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: index == 0 ? defaultMargin : 12,
                            ),
                            CardTool(
                              tools: objectDetailProvider
                                  .objectDetail.tools[index],
                            ),
                            SizedBox(
                              width: index ==
                                      objectDetailProvider
                                              .objectDetail.tools.length -
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              children: [
                appBar(),
                header(),
                videoMateri(),
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
              child: CustomButton(
                title: 'Tandakan Selesai & Next Video',
                method: methodForButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
