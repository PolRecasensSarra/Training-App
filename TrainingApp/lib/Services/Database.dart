import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String userName;
  final String userType;
  CollectionReference userCollection;

  DatabaseService({@required this.userName, @required this.userType}) {
    userCollection = FirebaseFirestore.instance.collection(userType);
  }

  Future updateUserDataWorker() async {
    return await userCollection.doc(userName).set({});
  }

  Future updateUserDataIndividual() async {
    return await userCollection.doc(userName).set({});
  }

  Future updateUserDataClient(String worker) async {
    //Set the client to the worker
    FirebaseFirestore.instance.collection("Worker").doc(worker).set({
      'clients': userName,
    });

    //Set the client's worker to client database
    return await userCollection.doc(userName).set({
      'worker': worker,
    });
  }

  Future checkIfUserNameIsTaken() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(userName)
        .get();
    if (doc.exists) return true;

    doc = await FirebaseFirestore.instance
        .collection("Client")
        .doc(userName)
        .get();
    if (doc.exists) return true;

    doc = await FirebaseFirestore.instance
        .collection("Individual")
        .doc(userName)
        .get();
    if (doc.exists) return true;

    return false;
  }

  Future checkIfReferralWorkerExist(String workerName) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(workerName)
        .get();
    if (doc.exists) return true;

    return false;
  }
}
