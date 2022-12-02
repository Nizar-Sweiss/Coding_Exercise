import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService extends ChangeNotifier {
  FirebaseService();
  //return an dynamic image type from the Download URL
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
