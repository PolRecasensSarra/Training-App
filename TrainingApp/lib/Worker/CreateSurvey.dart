import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/Services/Database.dart';
import 'package:training_app/Services/tools.dart';
import 'package:training_app/Shared/Loading.dart';

class CreateSurveyPage extends StatefulWidget {
  final DocumentSnapshot document;
  final String day;
  final User user;

  CreateSurveyPage(
      {@required this.document, @required this.day, @required this.user});
  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  final _formKey = GlobalKey<FormState>();
  String pathSurvey = "";
  bool validURL;
  String error = "";
  bool loading = false;
  DocumentSnapshot ds;
  String surveyError = "";
  TextEditingController _controller = TextEditingController();

  getSurveyPath() async {
    ds = await widget.document.reference
        .collection(widget.day)
        .doc("Survey")
        .get();
    if (ds.exists) {
      pathSurvey = ds.data()["survey"];
      setState(() {});
    }
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
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Edit Survey"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 20,
                  left: 38,
                  right: 38,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _controller,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[800],
                          prefixIcon: Icon(
                            Icons.poll,
                            color: Colors.white,
                          ),
                          labelText: pathSurvey,
                          contentPadding:
                              EdgeInsets.all(8.0), //here your padding
                          hintText: 'Enter a survey URL',
                          helperText:
                              "Please, provide an URL to a Survey.\nYou can use Google Forms to create a quick survey.",
                          helperMaxLines: 6,
                          hintStyle: TextStyle(fontSize: 12),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey[700]),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey[800]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey[800]),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            pathSurvey = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        child: Text("Open Survey"),
                        onPressed: () async {
                          bool valid = await Tools().canLaunchURL(pathSurvey);
                          if (valid) {
                            Tools().customLaunch(pathSurvey);
                          } else {
                            surveyError = "Invalid or Null link";
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        child: Text("Delete Survey URL"),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.red[400]),
                        onPressed: () async {
                          if (pathSurvey.isEmpty) {
                            surveyError = "No Surveys to delete";
                            setState(() {});
                            return;
                          }
                          bool result = await deleteExercise(ds);

                          if (!result) {
                            print(
                                "Something went wrond deleting this exercise");
                          } else {
                            print("Deleted Survey");
                            surveyError = "";
                            pathSurvey = "";
                            error = "";
                            _controller.clear();
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      surveyError,
                      style: TextStyle(color: Colors.red),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text("Go to Google Forms"),
                                onPressed: () {
                                  Tools().customLaunch(
                                      "https://docs.google.com/forms");
                                },
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent),
                                child: Text("SAVE"),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    validURL =
                                        await Tools().canLaunchURL(pathSurvey);
                                    if (!validURL) {
                                      setState(
                                          () => error = "Video URL not valid");
                                      return;
                                    }
                                    setState(() => loading = true);
                                    bool succes;
                                    succes = await DatabaseService(
                                            userName: widget.user.displayName,
                                            userType: "Worker")
                                        .saveSurvey(widget.document, widget.day,
                                            pathSurvey);
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
                            Text(
                              error,
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<bool> deleteExercise(DocumentSnapshot document) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.delete(document.reference);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
