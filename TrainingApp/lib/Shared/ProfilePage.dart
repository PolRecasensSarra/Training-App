import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';

class ProfilePage extends StatefulWidget {
  final UserType userType;
  final User user;
  ProfilePage({@required this.userType, @required this.user});
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
      drawer: CustomDrawerState()
          .createCustomDrawer(context, widget.userType, widget.user),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Username",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.user.displayName,
            ),
            SizedBox(height: 50),
            Text(
              "User type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
                widget.userType.toString().replaceAll(RegExp("UserType."), "")),
          ],
        ),
      ),
    );
  }
}
