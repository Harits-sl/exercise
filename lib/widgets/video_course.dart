import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:exercise/providers/youtube_id_provider.dart';

class VideoCourse extends StatefulWidget {
  final String youtubeId;

  const VideoCourse({
    Key? key,
    required this.youtubeId,
  }) : super(key: key);

  @override
  _VideoCourseState createState() => _VideoCourseState();
}

class _VideoCourseState extends State<VideoCourse> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
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
    YoutubePlayer youtubePlayer = YoutubePlayer(
      controller: _controller,
      // aspect ratio ketika landscape
      aspectRatio: 19 / 9,
    );
    Widget youtubePlayerHierarchy() {
      return YoutubePlayerBuilder(
        player: youtubePlayer,
        builder: (context, player) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: player,
              ),
            ],
          );
        },
      );
    }

    return youtubePlayerHierarchy();
  }
}
