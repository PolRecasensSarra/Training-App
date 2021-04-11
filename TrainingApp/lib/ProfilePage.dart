import 'package:TrainingApp/main.dart';
import 'package:flutter/material.dart';
import 'CustomDrawer.dart';

class ProfilePage extends StatefulWidget {
  UserType userType;
  ProfilePage({@required this.userType});
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
      drawer: CustomDrawerState().createCustomDrawer(context, widget.userType),
    );
  }
}
