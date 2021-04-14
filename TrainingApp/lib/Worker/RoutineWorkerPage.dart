import 'package:training_app/main.dart';
import 'package:training_app/Shared/AddExercisePage.dart';
import 'package:training_app/Worker/CreateSurvey.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class RoutineWorkerPage extends StatefulWidget {
  @override
  _RoutineWorkerPageState createState() => _RoutineWorkerPageState();
}

class _RoutineWorkerPageState extends State<RoutineWorkerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Routine"),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 28, bottom: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {},
                  ),
                  Text(
                    "Day of the Week",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
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
                        userType: UserType.worker,
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
