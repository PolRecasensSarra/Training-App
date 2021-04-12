import 'package:TrainingApp/ClientSurvey.dart';
import 'package:TrainingApp/main.dart';
import 'package:flutter/material.dart';
import 'CustomDrawer.dart';
import 'RoutineClientPage.dart';

class HomeClientPage extends StatefulWidget {
  UserType userType;
  HomeClientPage({@required this.userType});
  @override
  _HomeClientPageState createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: CustomDrawerState().createCustomDrawer(context, widget.userType),
      body: homePageClient(),
    );
  }

//--------------- CLIENT ----------------------
  homePageClient() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
