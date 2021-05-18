import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/Services/tools.dart';

class ClientSurveyPage extends StatefulWidget {
  final DocumentSnapshot document;
  final String day;
  ClientSurveyPage({@required this.document, @required this.day});
  @override
  _ClientSurveyPageState createState() => _ClientSurveyPageState();
}

class _ClientSurveyPageState extends State<ClientSurveyPage> {
  String surveyPath = "";
  String error = "";
  bool exist = false;

  getSurveyPath() async {
    DocumentSnapshot ds = await widget.document.reference
        .collection(widget.day)
        .doc("Survey")
        .get();
    if (ds.exists) {
      surveyPath = ds.data()["survey"];
      exist = true;
    }
    setState(() {});
  }

  setUp() async {
    await getSurveyPath();
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey"),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Open Survey"),
                  onPressed: () async {
                    if (surveyPath.isEmpty) {
                      error = "No surveys added";
                      setState(() {});
                      return;
                    }
                    bool canLaunch = await Tools().canLaunchURL(surveyPath);
                    if (canLaunch) {
                      Tools().customLaunch(surveyPath);
                    } else {
                      error = "Error launching survey URL";
                      setState(() {});
                    }
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
