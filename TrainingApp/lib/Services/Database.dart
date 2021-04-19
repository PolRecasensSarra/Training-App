import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String userName;
  final String userType;
  CollectionReference userCollection;

  DatabaseService({@required this.userName, @required this.userType}) {
    userCollection = FirebaseFirestore.instance.collection(userType);
  }

  Future updateUserData() async {
    return await userCollection.doc(userName).set({
      'Clients': "",
    });
  }
}
