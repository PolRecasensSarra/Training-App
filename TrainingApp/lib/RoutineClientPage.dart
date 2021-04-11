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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Day of the Week"),
            ElevatedButton(
              child: Text("Survey"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
