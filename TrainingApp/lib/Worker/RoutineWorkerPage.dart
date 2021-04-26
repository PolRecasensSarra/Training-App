import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/main.dart';
import 'package:training_app/Shared/AddExercisePage.dart';
import 'package:training_app/Worker/CreateSurvey.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class RoutineWorkerPage extends StatefulWidget {
  final DocumentSnapshot document;
  final User user;
  final DocumentSnapshot clientDocument;
  RoutineWorkerPage(
      {@required this.user,
      @required this.document,
      @required this.clientDocument});

  @override
  _RoutineWorkerPageState createState() => _RoutineWorkerPageState();
}

class _RoutineWorkerPageState extends State<RoutineWorkerPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientDocument.id + " Routine"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
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
                      height: 20,
                    ),
                    FutureBuilder(
                        future: getData(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
                                          snapshot.data.docs[index]
                                              .data()['sxr'],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        bool result = await deleteExercise(
                                            snapshot.data.docs[index]);
                                        if (!result) {
                                          print(
                                              "Something went wrond deleting this exercise");
                                        } else {
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Text("Description"),
                                                content: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    Text(snapshot
                                                        .data.docs[index]
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Image.asset(
                                                        "assets/logo.png"),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                      child: Text("Add exercise"),
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (contextCallback) => AddExercisePage(
                              user: widget.user,
                              document: widget.clientDocument,
                              day: days[dayIndex],
                            ),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text("Create Survey"),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contextCallback) => CreateSurveyPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('Worker')
        .doc(widget.user.displayName)
        .collection('clients')
        .doc(widget.clientDocument.id)
        .collection(days[dayIndex])
        .get();
  }

  Future<bool> deleteExercise(DocumentSnapshot document) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.delete(document.reference);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
