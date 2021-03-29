import 'package:flutter/material.dart';
import 'Worker.dart';
import 'Client.dart';
import 'Individual.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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

  getUserType() {
    return dropdownValue;
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

  createCustomDrawer(BuildContext contextCallback, String typeUser) {
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
              if (typeUser == "One") {
                Navigator.of(contextCallback).push(
                  MaterialPageRoute(
                    builder: (contextCallback) => HomePageWorker(),
                  ),
                );
              } else if (typeUser == "Two") {
                Navigator.of(contextCallback).push(
                  MaterialPageRoute(
                    builder: (contextCallback) => HomePageClient(),
                  ),
                );
              } else {
                Navigator.of(contextCallback).push(
                  MaterialPageRoute(
                    builder: (contextCallback) => HomePageIndividual(),
                  ),
                );
              }
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
                  builder: (contextCallback) => ProfilePage(typeUser),
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


//----------------PROFILE----------------------------
class ProfilePage extends StatefulWidget {
  final String typeUser;
  ProfilePage(this.typeUser);
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
      drawer: CustomDrawerState().createCustomDrawer(context, widget.typeUser),
      body: Center(
        child: Text("USERNAME"),
      ),
    );
  }
}

