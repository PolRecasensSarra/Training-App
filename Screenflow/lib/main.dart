import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepOrange),
              underline: Container(
                height: 2,
                color: Colors.orange[700],
              ),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>["One", 'Two', 'Three']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              width: 200.0,
              height: 100.0,
            ),
            ElevatedButton(
              child: Text("Go To Home"),
              onPressed: () {
                if (dropdownValue == 'One') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePageWorker(),
                    ),
                  );
                } else if (dropdownValue == 'Two') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePageClient(),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePageIndividual(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
      drawer: CustomDrawerState().createCustomDrawer(context),
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

//----------------PROFILE----------------------------
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Colors.black87,
      ),
      drawer: CustomDrawerState().createCustomDrawer(context),
      body: Center(
        child: Text("USERNAME"),
      ),
    );
  }
}

//------------------------------------------
//------------------------------------------
//------------------------------------------
//------------------------------------------
//------------------------------------------
//------------------------------------------
//--------------DRAWER----------------------
class CustomDrawer extends StatefulWidget {
  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  createCustomDrawer(BuildContext contextCallback) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Name SecondName LastName',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text('username@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue[300],
              backgroundImage: NetworkImage(
                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fmoonvillageassociation.org%2Fdefault-profile-picture1%2F&psig=AOvVaw0OHo7efIsXmUoUYK5d62uV&ust=1616785696213000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKiRvveRzO8CFQAAAAAdAAAAABAD",
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(contextCallback).push(
                MaterialPageRoute(
                  builder: (contextCallback) => HomePageWorker(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
            ),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(contextCallback).push(
                MaterialPageRoute(
                  builder: (contextCallback) => ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.email,
            ),
            title: Text(
              'Contact',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.info,
            ),
            title: Text(
              'More Info',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              showAboutDialog(
                context: contextCallback,
                applicationVersion: '0.01',
                applicationName: 'Rehealth',
                // applicationIcon: No va
                applicationLegalese: 'license here',
              );
            },
          ),
        ],
      ),
    );
  }
}
