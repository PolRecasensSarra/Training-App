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
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text('Exercici 1'),
                        trailing: Icon(Icons.delete),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Exercici 2'),
                        trailing: Icon(Icons.delete),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Exercici 3'),
                        trailing: Icon(Icons.delete),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("Add exercise"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => AddExercisePage(
                        user: widget.user,
                        document: widget.clientDocument,
                        day: days[dayIndex],
                      ),
                    ),
                  );
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
        ),
      ),
    );
  }
}
