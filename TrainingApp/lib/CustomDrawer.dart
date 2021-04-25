import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/Client/HomeClientPage.dart';
import 'package:training_app/Individual/HomeIndividualPage.dart';
import 'package:training_app/Services/auth.dart';
import 'package:training_app/Shared/LoginPage.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import 'Services/tools.dart';
import 'Worker/HomeWorkerPage.dart';
import 'Shared/ProfilePage.dart';
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

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  createCustomDrawer(BuildContext contextCallback, UserType typeUser, User user,
      DocumentSnapshot document) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.displayName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user.email,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xFFBC4B51),
              child: Text(
                user.displayName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Tools().createMaterialColor(Color(0xFF227A73)),
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
                        user: user,
                        document: document,
                      ),
                    ),
                  );
                } else if (typeUser == UserType.client) {
                  Navigator.of(contextCallback).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => HomeClientPage(
                        user: user,
                        document: document,
                      ),
                    ),
                  );
                } else if (typeUser == UserType.individual) {
                  Navigator.of(contextCallback).push(
                    MaterialPageRoute(
                      builder: (contextCallback) => HomeIndividualPage(
                        user: user,
                        document: document,
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
                  builder: (contextCallback) => ProfilePage(
                    userType: typeUser,
                    user: user,
                    document: document,
                  ),
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
                applicationIcon: Container(
                  child: Image.asset("assets/logo32.png"),
                ),
                context: contextCallback,
                applicationVersion: '0.01',
                applicationName: 'Rehealth',
                applicationLegalese: 'MIT License',
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () async {
              await _auth.signOut();
              Navigator.of(contextCallback).push(
                MaterialPageRoute(
                  builder: (contextCallback) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
