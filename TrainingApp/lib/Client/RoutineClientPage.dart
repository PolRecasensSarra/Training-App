import 'package:training_app/Client/ClientSurvey.dart';
import 'package:flutter/material.dart';

class RoutineClientPage extends StatefulWidget {
  @override
  _RoutineClientPageState createState() => _RoutineClientPageState();
}

class _RoutineClientPageState extends State<RoutineClientPage> {
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
              Text(
                "Day of the Week",
                style: TextStyle(
                  fontSize: 18,
                ),
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
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Exercici 2'),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Exercici 3'),
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
      ),
    );
  }
}
