import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    DocumentSnapshot docAux = snapshot.docs[0];

    clientDocument = await FirebaseFirestore
        .instance //Get the client collection from the worker
        .collection("Worker")
        .doc(docAux.id)
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
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  child: Text("Daily Routine"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RoutineClientPage(
                          user: widget.user,
                          document: clientDocument,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 4,
                child: Container(),
              ),
              Expanded(
                flex: 1,
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
            ],
          ),
        ),
      );
    } else
      return Center(child: CircularProgressIndicator());
  }
}
