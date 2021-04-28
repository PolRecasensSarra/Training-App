import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';

class ProfilePage extends StatefulWidget {
  final DocumentSnapshot document;
  final UserType userType;
  final User user;
  ProfilePage(
      {@required this.userType, @required this.user, @required this.document});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      drawer: CustomDrawerState().createCustomDrawer(
          context, widget.userType, widget.user, widget.document),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35.0),
          child: Column(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFBC4B51),
                  child: Text(
                    widget.user.displayName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "User Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.user.displayName,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "E-mail",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.user.email,
              ),
              SizedBox(height: 50),
              Text(
                "User Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text(widget.userType
                  .toString()
                  .replaceAll(RegExp("UserType."), "")),
            ],
          ),
        ),
      ),
    );
  }
}
