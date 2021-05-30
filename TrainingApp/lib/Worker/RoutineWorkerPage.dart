import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:training_app/Shared/EditExercisePage.dart';
import 'package:training_app/Shared/RoutineInfoPage.dart';
import 'package:training_app/Shared/AddExercisePage.dart';
import 'package:training_app/Worker/CreateSurvey.dart';
import 'package:flutter/material.dart';
import 'package:training_app/main.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController _controllerVideo;
  String actualDay = "";

  @override
  void initState() {
    DateTime date = DateTime.now();
    actualDay = DateFormat('EEEE').format(date);

    dayIndex = days.indexOf(actualDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientDocument.id + " Routine"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Row(
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
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 65,
                  child: FutureBuilder(
                      future: getData(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<QueryDocumentSnapshot> exercises =
                              getExerciseList(snapshot.data.docs);
                          if (exercises.isEmpty) {
                            return Text(
                              "No exercises added yet",
                              style: TextStyle(color: Colors.orangeAccent),
                            );
                          }
                          return Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              shrinkWrap: true,
                              itemCount: exercises.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            exercises[index].data()['name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "SxR: " +
                                                exercises[index].data()['sxr'],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          //onTap: () {},
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.open_in_new_outlined),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (contextCallback) =>
                                                  RoutineInfoPage(
                                                      clientDocument:
                                                          exercises[index]),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                                builder: (contextCallback) =>
                                                    EditExercisePage(
                                                        user: widget.user,
                                                        document: widget
                                                            .clientDocument,
                                                        exerciseDocument:
                                                            exercises[index],
                                                        day: days[dayIndex],
                                                        userType:
                                                            UserType.worker)),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          bool result = await deleteExercise(
                                              exercises[index]);
                                          if (!result) {
                                            print(
                                                "Something went wrond deleting this exercise");
                                          } else {
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
                        return Align(
                            alignment: Alignment.center,
                            child: SpinKitFadingCircle(
                              color: Colors.blueAccent,
                            ));
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 25,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Add exercise"),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (contextCallback) =>
                                        AddExercisePage(
                                      user: widget.user,
                                      document: widget.clientDocument,
                                      day: days[dayIndex],
                                      userType: UserType.worker,
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Survey"),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (contextCallback) =>
                                        CreateSurveyPage(
                                      day: days[dayIndex],
                                      document: widget.clientDocument,
                                      user: widget.user,
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

  List<QueryDocumentSnapshot> getExerciseList(
      List<QueryDocumentSnapshot> snapshot) {
    int length = snapshot.length;
    List<QueryDocumentSnapshot> list = List<QueryDocumentSnapshot>();
    for (int i = 0; i < length; ++i) {
      String survey = snapshot[i].id;
      if (survey != "Survey") {
        list.add(snapshot[i]);
      }
    }
    return list;
  }
}
