import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/Services/Database.dart';
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
  File fileImage;

  @override
  void initState() {
    super.initState();
  }

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
                  child: CachedNetworkImage(
                    key: ValueKey(new Random().nextInt(100)),
                    imageUrl: widget.document.data()['profilePic'],
                    placeholder: (context, url) => SpinKitFadingCircle(
                      color: Colors.teal,
                      size: 50,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    errorWidget: (context, url, error) => Text(
                      widget.user.displayName[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Upload Profile picture"),
                  IconButton(
                    icon: Icon(Icons.cloud_upload),
                    onPressed: () async {
                      fileImage = await DataStorageService().selectFile();
                      if (fileImage != null) {
                        String image =
                            await DataStorageService().uploadFile(fileImage);
                        await setProfilePicture(image);
                      }
                    },
                  ),
                ],
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
              SizedBox(
                height: 6,
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

  setProfilePicture(String path) async {
    bool succes;
    if (widget.userType == UserType.worker) {
      succes = await DatabaseService(
              userName: widget.user.displayName, userType: "Worker")
          .saveProfilePicture(widget.document, path);
    } else if (widget.userType == UserType.client) {
      succes = await DatabaseService(
              userName: widget.user.displayName, userType: "Client")
          .saveProfilePicture(widget.document, path);
    }

    if (succes) {
      imageCache.clear();
      imageCache.clearLiveImages();
      setState(() {});
    }
  }
}
