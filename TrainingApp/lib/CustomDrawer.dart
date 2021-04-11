import 'package:TrainingApp/HomeClientPage.dart';
import 'package:TrainingApp/HomeIndividualPage.dart';
import 'package:TrainingApp/main.dart';
import 'package:flutter/material.dart';
import 'HomeWorkerPage.dart';
import 'ProfilePage.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool toggleImageAccount = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  createCustomDrawer(BuildContext contextCallback, UserType typeUser) {
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
                if (typeUser == UserType.worker) {
                  Navigator.of(contextCallback).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => HomeWorkerPage(
                        userType: typeUser,
                      ),
                    ),
                  );
                } else if (typeUser == UserType.client) {
                  Navigator.of(contextCallback).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => HomeClientPage(
                        userType: typeUser,
                      ),
                    ),
                  );
                } else if (typeUser == UserType.individual) {
                  Navigator.of(contextCallback).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => HomeIndividualPage(
                        userType: typeUser,
                      ),
                    ),
                  );
                }
              }),
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
                  builder: (contextCallback) => ProfilePage(userType: typeUser),
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
            onTap: () {
              customLaunch(
                  'mailto:polrecasenssarra@hotmail.com?subject=Assumpte&body=Descripció');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
            ),
            title: Text(
              'Information',
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
