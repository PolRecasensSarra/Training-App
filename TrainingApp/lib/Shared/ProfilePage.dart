import 'dart:io';
import 'dart:math';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/Services/Database.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  DocumentSnapshot document;
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
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Column(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
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
                height: 40,
              ),
              Card(
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                    ),
                    title: Text(
                      widget.user.displayName,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(
                      widget.user.email,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading: Icon(Icons.accessibility),
                    title: Text(widget.userType
                        .toString()
                        .replaceAll(RegExp("UserType."), "")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setProfilePicture(String path) async {
    bool succes;
    String lastPath = widget.document.data()['profilePic'];
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
      await CachedNetworkImage.evictFromCache(lastPath);

      DocumentSnapshot dc;
      if (widget.userType == UserType.worker) {
        dc = await FirebaseFirestore.instance
            .collection("Worker")
            .doc(widget.user.displayName)
            .get();
      } else if (widget.userType == UserType.client) {
        dc = await FirebaseFirestore.instance
            .collection("Client")
            .doc(widget.user.displayName)
            .get();
      }
      widget.document = dc;

      setState(() {});
    }
  }
}
