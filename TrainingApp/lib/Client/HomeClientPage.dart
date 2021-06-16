import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:training_app/Services/tools.dart';
import 'package:training_app/Shared/RoutineInfoPage.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';

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
  String surveyPath = "";
  String actualDay = "";
  String error = "";

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

    DateTime date = DateTime.now();
    actualDay = DateFormat('EEEE').format(date);

    dayIndex = days.indexOf(actualDay);

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
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
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
                            error = "";
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
                            error = "";
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
                  height: 30,
                ),
                Expanded(
                  flex: 85,
                  child: FutureBuilder(
                    future: getData(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot> exercises =
                            getExerciseList(snapshot.data.docs);
                        if (exercises.isEmpty) {
                          return Text(
                            "No routines added yet",
                            style: TextStyle(color: Colors.orangeAccent),
                          );
                        }
                        return Scrollbar(
                          isAlwaysShown: true,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 26),
                            shrinkWrap: true,
                            itemCount: exercises.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  trailing: Icon(Icons.open_in_new_outlined),
                                  title: Text(
                                    exercises[index].data()['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "SxR: " + exercises[index].data()['sxr'],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (contextCallback) =>
                                            RoutineInfoPage(
                                          clientDocument: exercises[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.data.docs.isEmpty) {
                        return Text(
                          "No routines added yet",
                          style: TextStyle(color: Colors.orangeAccent),
                        );
                      }
                      return Align(
                          alignment: Alignment.center,
                          child: SpinKitFadingCircle(
                            color: Color(0xFF227A73),
                          ));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 25,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          child: Text("Survey"),
                          onPressed: () {
                            launchSurveyURL();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ],
            ),
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

  launchSurveyURL() async {
    String path = await getSurveyPath();
    if (path.isEmpty) {
      error = "No surveys added";
      setState(() {});
      return;
    }
    bool canLaunch = await Tools().canLaunchURL(path);
    if (canLaunch) {
      Tools().customLaunch(path);
      error = "";
    } else {
      error = "Error launching survey URL";
      setState(() {});
    }
  }

  getSurveyPath() async {
    DocumentSnapshot ds = await clientDocument.reference
        .collection(days[dayIndex])
        .doc("Survey")
        .get();
    if (ds.exists) {
      return ds.data()["survey"];
    } else {
      return "";
    }
  }
}
