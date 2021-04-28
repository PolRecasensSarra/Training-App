import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/Client/ClientSurvey.dart';
import 'package:flutter/material.dart';

class RoutineClientPage extends StatefulWidget {
  final DocumentSnapshot clientDocument;
  final DocumentSnapshot workerDocument;
  final User user;
  final String day;
  RoutineClientPage(
      {@required this.user,
      @required this.clientDocument,
      @required this.workerDocument,
      @required this.day});
  @override
  _RoutineClientPageState createState() => _RoutineClientPageState();
}

class _RoutineClientPageState extends State<RoutineClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routine"),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 28, bottom: 28),
          child: Column(
            children: [
              Text(
                widget.day,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: getData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                snapshot.data.docs[index].data()['name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "SxR: " +
                                    snapshot.data.docs[index].data()['sxr'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          content: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Text(
                                                "Description",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(snapshot.data.docs[index]
                                                  .data()['description']),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 1,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Image",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data.docs[index]
                                                    .data()['imageURL'],
                                                placeholder: (context, url) =>
                                                    SpinKitFadingCircle(
                                                  color: Colors.teal,
                                                  size: 50,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Text(
                                                  "No images found",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 1,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Video",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text((snapshot.data.docs[index]
                                                  .data()['videoURL'])),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.close,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ));
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        (widget.clientDocument == null ||
                            !widget.clientDocument.exists)) {
                      return Text(
                        "Client Document does not exist",
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("Survey"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => ClientSurveyPage(
                        document: widget.clientDocument,
                        user: widget.user,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('Worker')
        .doc(widget.workerDocument.id)
        .collection('clients')
        .doc(widget.clientDocument.id)
        .collection(widget.day)
        .get();
  }
}
