import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

//This class handles upload file (Images) to the firebase Storage
class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
/*Upload a [File] from the filesystem. The file must exist.
    filePath : file path from the Storage in firebase .
    fileName : Name of the file to be uploaded into firebase .
*/
  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
