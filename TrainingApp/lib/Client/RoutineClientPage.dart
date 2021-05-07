import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RoutineClientPage extends StatefulWidget {
  final DocumentSnapshot clientDocument;

  RoutineClientPage({
    @required this.clientDocument,
  });
  @override
  _RoutineClientPageState createState() => _RoutineClientPageState();
}

class _RoutineClientPageState extends State<RoutineClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routine Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              color: Color(0xFF6E7F80),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.clientDocument.data()['name']),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xFF536872),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Series and Repetitions",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.clientDocument.data()['sxr']),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xFF708090),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.clientDocument.data()['description']),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xFF536878),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Image",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.clientDocument.data()['imageURL'],
                        placeholder: (context, url) => SpinKitFadingCircle(
                          color: Colors.teal,
                          size: 50,
                        ),
                        errorWidget: (context, url, error) => Text(
                          "No images found",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Color(0xFF36454F),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Video",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text((widget.clientDocument.data()['videoURL'])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
