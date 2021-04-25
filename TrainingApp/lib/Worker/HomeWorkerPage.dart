import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/main.dart';
import 'package:flutter/material.dart';
import '../CustomDrawer.dart';
import '../Individual/RoutineIndividualPage.dart';
import 'RoutineWorkerPage.dart';

class HomeWorkerPage extends StatefulWidget {
  final DocumentSnapshot document;
  final User user;
  HomeWorkerPage({@required this.user, @required this.document});

  List<DocumentSnapshot> clients;
  QuerySnapshot snapshot;

  @override
  _HomeWorkerPageState createState() => _HomeWorkerPageState();
}

class _HomeWorkerPageState extends State<HomeWorkerPage> {
  setup() async {
    await setUpStatus();
  }

  setUpStatus() async {
    widget.snapshot = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(widget.user.displayName)
        .collection("clients")
        .get();

    widget.clients = widget.snapshot.docs;
  }

  @override
  void initState() {
    setup();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            Image.asset(
              "assets/logo.png",
            ),
          ],
        ),
        drawer: CustomDrawerState().createCustomDrawer(
            context, UserType.worker, widget.user, widget.document),
        body: homePageWorker(),
      ),
    );
  }

//--------------- WORKER ----------------------
  homePageWorker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      child: Center(
        child: Column(
          children: [
            Text(
              "Client List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      widget.clients != null &&
                      widget.clients.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.clients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color(widget.clients[index].data()['color']),
                              child: Text(
                                widget.clients[index].id[0].toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              widget.clients[index].id,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (contextCallback) =>
                                        RoutineWorkerPage(
                                      user: widget.user,
                                      document: widget.document,
                                      clientDocument: widget.clients[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      (widget.clients == null || widget.clients.isEmpty)) {
                    return Text(
                      "You have no clients",
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

//--------------- INDIVIDUAL ----------------------
  homePageIndividual() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Daily Routine"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoutineIndividualPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Edit"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('Worker')
        .doc(widget.user.displayName)
        .collection('clients')
        .get();
  }
  //
}
