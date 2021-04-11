import 'package:TrainingApp/main.dart';
import 'package:flutter/material.dart';
import 'CustomDrawer.dart';

class HomePage extends StatefulWidget {
  UserType userType;
  HomePage({@required this.userType});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: CustomDrawerState().createCustomDrawer(context, widget.userType),
      body: callHomePage(widget.userType),
    );
  }

  callHomePage(UserType userType) {
    switch (userType) {
      case UserType.worker:
        {
          return homePageWorker();
        }
      case UserType.client:
        {
          return homePageClient();
        }
      case UserType.individual:
        {
          return homePageIndividual();
        }
      default:
    }
  }

//--------------- WORKER ----------------------
  homePageWorker() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
      child: Column(
        children: [
          Text(
            "Client List",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: const <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                    ),
                    title: Text('Pol Recasens Sarrà'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                    ),
                    title: Text('Ivan Ropero'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                    ),
                    title: Text('Oriol Capdevila'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text("Survey"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  //----------------------------------------------------------------------

//--------------- INDIVIDUAL ----------------------
  homePageIndividual() {
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
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text("Edit"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //
  //
}
