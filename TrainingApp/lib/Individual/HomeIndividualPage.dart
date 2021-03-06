import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:training_app/Shared/EditExercisePage.dart';
import 'package:training_app/Shared/RoutineInfoPage.dart';
import 'package:training_app/Shared/AddExercisePage.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';

class HomeIndividualPage extends StatefulWidget {
  final DocumentSnapshot document;
  final User user;
  HomeIndividualPage({@required this.user, @required this.document});
  @override
  _HomeIndividualPageState createState() => _HomeIndividualPageState();
}

class _HomeIndividualPageState extends State<HomeIndividualPage> {
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  int dayIndex = 0;
  String actualDay = "";

  @override
  void initState() {
    DateTime date = DateTime.now();
    actualDay = DateFormat('EEEE').format(date);
    dayIndex = days.indexOf(actualDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routines"),
      ),
      drawer: CustomDrawerState().createCustomDrawer(
          context, UserType.individual, widget.user, widget.document),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            if (dayIndex == 0)
                              setState(() {
                                dayIndex = 6;
                              });
                            else
                              setState(() {
                                dayIndex--;
                              });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            days[dayIndex],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            if (dayIndex == 6)
                              setState(() {
                                dayIndex = 0;
                              });
                            else
                              setState(() {
                                dayIndex++;
                              });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 70,
                  child: FutureBuilder(
                      future: getData(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data.docs[index]
                                                .data()['name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "SxR: " +
                                                snapshot.data.docs[index]
                                                    .data()['sxr'],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.open_in_new_outlined),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (contextCallback) =>
                                                  RoutineInfoPage(
                                                clientDocument:
                                                    snapshot.data.docs[index],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                                builder: (contextCallback) =>
                                                    EditExercisePage(
                                                        user: widget.user,
                                                        document:
                                                            widget.document,
                                                        exerciseDocument:
                                                            snapshot.data
                                                                .docs[index],
                                                        day: days[dayIndex],
                                                        userType: UserType
                                                            .individual)),
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          bool result = await deleteExercise(
                                              snapshot.data.docs[index]);
                                          if (!result) {
                                            print(
                                                "Something went wrond deleting this exercise");
                                          } else {
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            (widget.document == null ||
                                !widget.document.exists)) {
                          return Text(
                            "Client Document does not exist",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return Align(
                            alignment: Alignment.center,
                            child: SpinKitFadingCircle(
                              color: Color(0xFF227A73),
                            ));
                      }),
                ),
                Expanded(
                  flex: 20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Add exercise"),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (contextCallback) =>
                                        AddExercisePage(
                                      user: widget.user,
                                      document: widget.document,
                                      day: days[dayIndex],
                                      userType: UserType.worker,
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('Individual')
        .doc(widget.user.displayName)
        .collection(days[dayIndex])
        .get();
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
