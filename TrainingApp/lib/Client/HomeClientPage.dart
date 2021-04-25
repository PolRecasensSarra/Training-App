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
  String actualDay;
  int dayIndex = 0;
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
            ElevatedButton(
              child: Text("Daily Routine"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoutineClientPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text("Survey"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contextCallback) => ClientSurveyPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
