import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';
import 'RoutineIndividualPage.dart';

class HomeIndividualPage extends StatefulWidget {
  final UserType userType;
  HomeIndividualPage({@required this.userType});
  @override
  _HomeIndividualPageState createState() => _HomeIndividualPageState();
}

class _HomeIndividualPageState extends State<HomeIndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: CustomDrawerState().createCustomDrawer(context, widget.userType),
      body: homePageIndividual(),
    );
  }

//--------------- INDIVIDUAL ----------------------
  homePageIndividual() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
            ElevatedButton(
              child: Text("Daily Routine"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoutineIndividualPage(),
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
