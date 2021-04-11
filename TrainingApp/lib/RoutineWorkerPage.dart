import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Add exercise"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
