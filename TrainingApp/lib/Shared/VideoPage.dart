import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/Widgets/VideoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class Videopage extends StatefulWidget {
  final DocumentSnapshot document;
  Videopage({@required this.document});
  @override
  _VideopageState createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.network(widget.document.data()['videoURL'])
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((value) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: VideoPlayerWidget(controller: controller),
    );
  }
}
