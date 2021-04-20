import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:training_app/main.dart';

class DatabaseService {
  final String userName;
  final String userType;
  CollectionReference userCollection;

  DatabaseService({@required this.userName, @required this.userType}) {
    userCollection = FirebaseFirestore.instance.collection(userType);
  }

  Future updateUserData() async {
    if (userType == "Worker") {
      return await userCollection.doc(userName).set({
        'clients': "",
      });
    } else if (userType == "Client") {
      return await userCollection.doc(userName).set({
        'worker': "",
      });
    } else {
      return await userCollection.doc(userName).set({
        'individual': "",
      });
    }
  }

  Future checkIfUserNameIsTaken() async {
    DocumentSnapshot doc = await userCollection.doc("Worker").get();
    if (doc.exists) return true;

    doc = await userCollection.doc("Client").get();
    if (doc.exists) return true;

    doc = await userCollection.doc("Individual").get();
    if (doc.exists) return true;

    return false;
  }
}
