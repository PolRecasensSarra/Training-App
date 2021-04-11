import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Day of the Week"),
            ElevatedButton(
              child: Text("Edit"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
