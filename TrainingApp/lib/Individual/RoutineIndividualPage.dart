import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../Shared/AddExercisePage.dart';
import '../main.dart';

class RoutineIndividualPage extends StatefulWidget {
  @override
  _RoutineIndividualPageState createState() => _RoutineIndividualPageState();
}

class _RoutineIndividualPageState extends State<RoutineIndividualPage> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Day of the Week"),
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
                child: Text("Add Exercise"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => AddExercisePage(
                        userType: UserType.individual,
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
}
