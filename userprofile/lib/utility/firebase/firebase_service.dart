import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

//Since we only have one user for now ,we can use this doc Id
final String userID = "TqrALtHASBtcgstKLGUx";

CollectionReference<Map<String, dynamic>> userCollection =
    FirebaseFirestore.instance.collection("users");

class FirebaseService extends ChangeNotifier {
  FirebaseService();
  //return an dynamic image type from the Download URL
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
