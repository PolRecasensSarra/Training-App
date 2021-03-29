import 'package:flutter/material.dart';
import 'main.dart';

//----------------------HOME--------------------------------
class HomePageWorker extends StatefulWidget {
  @override
  _HomePageWorkerState createState() => _HomePageWorkerState();
}

class _HomePageWorkerState extends State<HomePageWorker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.black87,
      ),
      drawer: CustomDrawerState().createCustomDrawer(context, "One"),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Client 1"),
            leading: Icon(
              Icons.account_circle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ClientPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Client 2"),
            leading: Icon(
              Icons.account_circle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ClientPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Client 3"),
            leading: Icon(
              Icons.account_circle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ClientPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Client 4"),
            leading: Icon(
              Icons.account_circle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ClientPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//----------------------CLIENT--------------------------------
class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Page"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Edit Routine"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoutinePage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Edit Quiz"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuizPage(),
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

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Page"),
        backgroundColor: Colors.black87,
      ),
    );
  }
}


