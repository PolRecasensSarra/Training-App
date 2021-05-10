import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/Services/Database.dart';
import 'package:training_app/Shared/Loading.dart';
import 'package:training_app/main.dart';

class AddExercisePage extends StatefulWidget {
  final User user;
  final DocumentSnapshot document;
  final String day;
  final UserType userType;
  AddExercisePage(
      {@required this.user,
      @required this.document,
      @required this.day,
      @required this.userType});
  @override
  _AddExercisePageState createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  String name = "";
  String sxr = "";
  String description = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = "";
  String pathImage = "";
  String pathVideo = "";
  File fileImage;
  File fileVideo;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text("Add Exercise"),
            ),
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.day.toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[800],
                              labelText: "Name",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                              contentPadding:
                                  EdgeInsets.all(8.0), //here your padding
                              hintText: 'Enter exercise name',
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[700]),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[800]),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[800]),
                              ),
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a name" : null,
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[800],
                              labelText: "SxR",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                              contentPadding:
                                  EdgeInsets.all(8.0), //here your padding
                              hintText: 'Enter sessions and repetitions',
                              hintStyle: TextStyle(fontSize: 12),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[700]),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[800]),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[800]),
                              ),
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a SxR" : null,
                            onChanged: (val) {
                              setState(() {
                                sxr = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: "Description",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                              contentPadding:
                                  EdgeInsets.all(8.0), //here your padding
                              hintText: 'Enter a description',
                              hintStyle: TextStyle(fontSize: 12),
                              filled: true,
                              fillColor: Colors.grey[800],
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[700]),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[800]),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[800]),
                              ),
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a description" : null,
                            onChanged: (val) {
                              setState(() {
                                description = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Image",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_file,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Select Image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      fileImage = await DataStorageService()
                                          .selectFile();
                                      if (fileImage != null) {
                                        setState(() {
                                          pathImage =
                                              fileImage.path.split('/').last;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              pathImage,
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Video",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_file,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Select Video",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      fileVideo = await DataStorageService()
                                          .selectFile();
                                      if (fileVideo != null) {
                                        setState(() {
                                          pathVideo =
                                              fileVideo.path.split('/').last;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              pathVideo,
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            color: Colors.white,
                            height: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("SAVE"),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  //Upload Image
                                  String image = await DataStorageService()
                                      .uploadFile(fileImage);
                                  //Upload Video
                                  String video = await DataStorageService()
                                      .uploadFile(fileVideo);
                                  //Upload Exercises
                                  bool succes;
                                  if (widget.userType == UserType.worker) {
                                    succes = await DatabaseService(
                                            userName: widget.user.displayName,
                                            userType: "Worker")
                                        .saveExercise(
                                            widget.document,
                                            widget.day,
                                            name,
                                            sxr,
                                            description,
                                            image,
                                            video);
                                  } else if (widget.userType ==
                                      UserType.individual) {
                                    succes = await DatabaseService(
                                            userName: widget.user.displayName,
                                            userType: "Individual")
                                        .saveExercise(
                                            widget.document,
                                            widget.day,
                                            name,
                                            sxr,
                                            description,
                                            image,
                                            video);
                                  }
                                  if (succes) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.of(context).pop(succes);
                                  } else {
                                    setState(
                                        () => error = "Something went wrong");
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
