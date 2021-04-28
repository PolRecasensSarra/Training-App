import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/Client/ClientSurvey.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';
import 'RoutineClientPage.dart';

class HomeClientPage extends StatefulWidget {
  final DocumentSnapshot document;
  final User user;
  HomeClientPage({@required this.user, @required this.document});
  @override
  _HomeClientPageState createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  int dayIndex = 0;
  DocumentSnapshot clientDocument;
  DocumentSnapshot workerDocument;

  setup() async {
    await getClientWorker();
  }

  getClientWorker() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance //Get the worker ID
            .collection("Client")
            .doc(widget.user.displayName)
            .collection("worker")
            .get();

    workerDocument = snapshot.docs[0];

    clientDocument = await FirebaseFirestore
        .instance //Get the client collection from the worker
        .collection("Worker")
        .doc(workerDocument.id)
        .collection("clients")
        .doc(widget.user.displayName)
        .get();
    setState(() {});
  }

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
            context, UserType.client, widget.user, widget.document),
        body: homePageClient(),
      ),
    );
  }

//--------------- CLIENT ----------------------
  homePageClient() {
    if (clientDocument != null && clientDocument.exists) {
      return Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (dayIndex == 0)
                          setState(() {
                            dayIndex = 6;
                          });
                        else
                          setState(() {
                            dayIndex--;
                          });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        days[dayIndex],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        if (dayIndex == 6)
                          setState(() {
                            dayIndex = 0;
                          });
                        else
                          setState(() {
                            dayIndex++;
                          });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder(
                  future: getData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data.docs.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              trailing: Icon(Icons.open_in_new_outlined),
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
                                          "Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(snapshot.data.docs[index]
                                            .data()['name']),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey[700],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Series and Repetitions",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(snapshot.data.docs[index]
                                            .data()['sxr']),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey[700],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
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
                                          color: Colors.grey[700],
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
                                          imageUrl: snapshot.data.docs[index]
                                              .data()['imageURL'],
                                          placeholder: (context, url) =>
                                              SpinKitFadingCircle(
                                            color: Colors.teal,
                                            size: 50,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Text(
                                            "No images found",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey[700],
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
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.data.docs.isEmpty) {
                      return Text(
                        "No routines added yet :(",
                        style: TextStyle(color: Colors.greenAccent),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    child: Text("Survey"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contextCallback) => ClientSurveyPage(
                            user: widget.user,
                            document: clientDocument,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else
      return Center(child: CircularProgressIndicator());
  }

  Future<bool> checkIfClientHasRoutine() async {
    QuerySnapshot qs =
        await clientDocument.reference.collection(days[dayIndex]).get();

    if (qs.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<QuerySnapshot> getData() async {
    return await clientDocument.reference.collection(days[dayIndex]).get();
  }
}
