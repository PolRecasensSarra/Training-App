import 'package:flutter/material.dart';

class AddExercisePage extends StatefulWidget {
  @override
  _AddExercisePageState createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exercise"),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 28, bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Name"),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("SxR"),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Description"),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 16, bottom: 20),
                color: Colors.grey[800],
                height: 130,
              ),
              ElevatedButton(
                child: Text("ENTER"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
