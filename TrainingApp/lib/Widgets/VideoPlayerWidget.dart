import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller != null && controller.value.isInitialized
        ? Container(alignment: Alignment.topCenter, child: buildVideo())
        : SpinKitFadingCircle(
            color: Color(0xFF227A73),
          );
  }

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => VideoPlayer(controller);
}
