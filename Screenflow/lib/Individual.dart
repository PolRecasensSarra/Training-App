import 'package:flutter/material.dart';
import 'main.dart';


class HomePageIndividual extends StatefulWidget {
  @override
  _HomePageIndividualState createState() => _HomePageIndividualState();
}

class _HomePageIndividualState extends State<HomePageIndividual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Individual Page"),
        backgroundColor: Colors.black87,
      ),
      drawer: CustomDrawerState().createCustomDrawer(context, "Three"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("View Routine"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoutinePage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Edit Routine"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditRoutinePage(),
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

class RoutinePage extends StatefulWidget {
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routine Page"),
        backgroundColor: Colors.black87,
      ),
    );
  }
}

class EditRoutinePage extends StatefulWidget {
  @override
  _EditRoutinePageState createState() => _EditRoutinePageState();
}

class _EditRoutinePageState extends State<EditRoutinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Routine Page"),
        backgroundColor: Colors.black87,
      ),
    );
  }
}