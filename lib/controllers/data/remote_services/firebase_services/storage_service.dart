import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage firebaseStorage;

  StorageService(this.firebaseStorage);

  Future<String> uploadImage(String imagePath, String path, String id) async {
    Reference storageReference = firebaseStorage.ref().child("$path/$id.png");

    UploadTask uploadTask = storageReference.putFile(File(imagePath), SettableMetadata(
      contentType: "image/png",
    ));

    await uploadTask;

    String imageUrl = await storageReference.getDownloadURL();
    print("image_1234412 : $imageUrl");
    return imageUrl;
  }

  Future uploadImageWithOutGettingURL(
      String imagePath, String path, String id) async {
    Reference storageReference = firebaseStorage.ref().child("$path/$id.png");
    UploadTask uploadTask = storageReference.putFile(
        File(imagePath),
        SettableMetadata(
          contentType: "image/png",
        ));
    await uploadTask;
  }

  Future deleteImage(String path, String id) async {
    Reference storageReference = firebaseStorage.ref().child("$path/$id.png");
    storageReference.delete();
  }
}
