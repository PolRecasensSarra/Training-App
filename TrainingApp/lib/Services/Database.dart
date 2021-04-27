import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:training_app/Services/tools.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class DatabaseService {
  final String userName;
  final String userType;
  CollectionReference userCollection;

  DatabaseService({@required this.userName, @required this.userType}) {
    userCollection = FirebaseFirestore.instance.collection(userType);
  }

  updateUserDataWorker() async {
    userCollection.doc(userName).set({});
  }

  Future updateUserDataIndividual() async {
    return await userCollection.doc(userName).set({});
  }

  updateUserDataClient(String worker) async {
    //Set the client to the worker

    FirebaseFirestore.instance
        .collection("Worker")
        .doc(worker)
        .collection("clients")
        .doc(userName)
        .set({'color': Tools().generateRandomColor()});

    //Set the client's worker to client database
    userCollection.doc(userName).set({});
    userCollection.doc(userName).collection("worker").doc(worker).set({});
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

  Future<DocumentSnapshot> getDocumentSnapshot() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Worker")
        .doc(userName)
        .get();
    if (doc.exists) return doc;

    doc = await FirebaseFirestore.instance
        .collection("Client")
        .doc(userName)
        .get();
    if (doc.exists) return doc;

    doc = await FirebaseFirestore.instance
        .collection("Individual")
        .doc(userName)
        .get();
    if (doc.exists) return doc;

    return null;
  }

  //------- EXERCISES
  Future<bool> saveExercise(DocumentSnapshot doc, String day,
      String exerciseName, String sxr, String description, String image) async {
    try {
      doc.reference.collection(day).doc(exerciseName).set({
        'name': exerciseName,
        'sxr': sxr,
        'description': description,
        'imageURL': image
      });
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}

class DataStorageService {
  DataStorageService();

  Future<dynamic> selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path;

    return File(path);
  }

  Future<String> uploadFile(File file) async {
    if (file == null) return "";

    final fileName = file.path.split('/').last;
    final destination = 'files/$fileName';

    final ref = FirebaseStorage.instance.ref(destination);
    UploadTask uploadTask = ref.putFile(file);

    if (uploadTask == null) return "";

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}
