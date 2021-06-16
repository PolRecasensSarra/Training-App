import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/Services/Database.dart';
import 'package:training_app/Shared/Loading.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  final UserType userType;
  final User user;
  ProfilePage({@required this.userType, @required this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File fileImage;
  DocumentSnapshot document;
  bool loading = true;
  String errorImage = "";

  @override
  void initState() {
    setUp();
    super.initState();
  }

  setUp() async {
    await getDocument();
  }

  getDocument() async {
    if (widget.userType == UserType.worker) {
      document = await FirebaseFirestore.instance
          .collection("Worker")
          .doc(widget.user.displayName)
          .get();
    } else if (widget.userType == UserType.client) {
      document = await FirebaseFirestore.instance
          .collection("Client")
          .doc(widget.user.displayName)
          .get();
    } else if (widget.userType == UserType.individual) {
      document = await FirebaseFirestore.instance
          .collection("Individual")
          .doc(widget.user.displayName)
          .get();
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
            ),
            drawer: CustomDrawerState().createCustomDrawer(
                context, widget.userType, widget.user, document),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 38,
                ),
                child: Column(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          key: ValueKey(new Random().nextInt(100)),
                          imageUrl: document.data()['profilePic'],
                          placeholder: (context, url) => SpinKitFadingCircle(
                            color: Color(0xFF227A73),
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
                              int size = await fileImage.length();
                              if (size / pow(1024, 2) > 10) {
                                setState(() {
                                  errorImage =
                                      "Image size cannot exceeds 10 MB";
                                  fileImage = null;
                                });
                                return;
                              }
                              String image = await DataStorageService()
                                  .uploadFile(fileImage);
                              await setProfilePicture(image);
                              setState(() {
                                errorImage = "";
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      errorImage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
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
    String lastPath = document.data()['profilePic'];
    if (widget.userType == UserType.worker) {
      succes = await DatabaseService(
              userName: widget.user.displayName, userType: "Worker")
          .saveProfilePicture(document, path);
    } else if (widget.userType == UserType.client) {
      succes = await DatabaseService(
              userName: widget.user.displayName, userType: "Client")
          .saveProfilePicture(document, path);
    } else if (widget.userType == UserType.individual) {
      succes = await DatabaseService(
              userName: widget.user.displayName, userType: "Individual")
          .saveProfilePicture(document, path);
    }

    if (succes) {
      await CachedNetworkImage.evictFromCache(lastPath);
      getDocument();
      setState(() {});
    }
  }
}
