import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/providers/youtube_id_provider.dart';
import 'package:exercise/theme.dart';

class Materi extends StatelessWidget {
  final materi;
  final bool isDone;

  const Materi({
    Key? key,
    required this.isDone,
    this.materi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);

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
}
