import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/Services/tools.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';
import 'RoutineWorkerPage.dart';

class HomeWorkerPage extends StatefulWidget {
  final DocumentSnapshot document;
  final User user;
  HomeWorkerPage({@required this.user, @required this.document});

  List<DocumentSnapshot> clients;
  QuerySnapshot snapshot;

  @override
  _HomeWorkerPageState createState() => _HomeWorkerPageState();
}

class _HomeWorkerPageState extends State<HomeWorkerPage> {
  String actualDay = "";
  List<DocumentSnapshot> clientCopy = List<DocumentSnapshot>();
  setup() async {
    await setUpStatus();
  }

  setUpStatus() async {
    widget.snapshot = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(widget.user.displayName)
        .collection("clients")
        .get();

    widget.clients = widget.snapshot.docs;
  }

  @override
  void initState() {
    setup();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            Image.asset(
              "assets/logo.png",
            ),
          ],
        ),
        drawer: CustomDrawerState().createCustomDrawer(
            context, UserType.worker, widget.user, widget.document),
        body: homePageWorker(),
      ),
    );
  }

//--------------- WORKER ----------------------
  homePageWorker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      child: Center(
        child: Column(
          children: [
            Text(
              "Client List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data.docs.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: selectProfilePic(clientCopy[index]),
                            title: Text(
                              snapshot.data.docs[index].id,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (contextCallback) =>
                                        RoutineWorkerPage(
                                      user: widget.user,
                                      document: widget.document,
                                      clientDocument: snapshot.data.docs[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data.docs.isEmpty) {
                    return Text(
                      "You have no clients",
                      style: TextStyle(color: Colors.tealAccent),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  Future<QuerySnapshot> getData() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('Worker')
        .doc(widget.user.displayName)
        .collection('clients')
        .get();
    int lenght = qs.docs.length;
    CollectionReference cr = FirebaseFirestore.instance.collection("Client");

    for (int i = 0; i < lenght; ++i) {
      DocumentSnapshot ds = await cr.doc(qs.docs[i].id).get();
      clientCopy.add(ds);
    }

    return qs;
  }

  selectProfilePic(DocumentSnapshot doc) {
    String pic = doc.data()['profilePic'];
    if (pic == Tools().getProfilePicDefault()) {
      return Container(
        child: CircleAvatar(
          backgroundColor: Color(0xFFF05F3C),
          child: Text(
            doc.id[0].toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: CachedNetworkImage(
            key: ValueKey(new Random().nextInt(100)),
            imageUrl: doc.data()['profilePic'],
            placeholder: (context, url) => SpinKitFadingCircle(
              color: Color(0xFF227A73),
              size: 30,
            ),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => Text(
              doc.id[0].toUpperCase(),
              style: TextStyle(
                fontSize: 42,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }
}
