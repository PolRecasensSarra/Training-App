import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
            currentAccountPicture: selectProfilePic(user, document),
            decoration: BoxDecoration(
              color: Tools().createMaterialColor(Color(0xFF3A7A75)),
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
              'Contact Developer',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Tools().customLaunch(
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
                applicationName: 'ImproveMe',
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

  selectProfilePic(User user, DocumentSnapshot doc) {
    String pic = doc.data()['profilePic'];
    if (pic == Tools().getProfilePicDefault()) {
      return CircleAvatar(
        backgroundColor: Color(0xFFF05F3C),
        child: Text(
          user.displayName[0].toUpperCase(),
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: CachedNetworkImage(
          key: ValueKey(new Random().nextInt(100)),
          imageUrl: doc.data()['profilePic'],
          placeholder: (context, url) => SpinKitFadingCircle(
            color: Colors.blueAccent,
            size: 50,
          ),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          errorWidget: (context, url, error) => Text(
            user.displayName[0].toUpperCase(),
            style: TextStyle(
              fontSize: 42,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}
