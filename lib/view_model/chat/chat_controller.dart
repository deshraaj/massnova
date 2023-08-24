import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/view_model/services/session_manager.dart';

class ChatController with ChangeNotifier {
  final picker = ImagePicker();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  XFile? _image;

  XFile? get image => _image;

  Future pickGallaryImage(BuildContext context,String uid) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference myPostRef = FirebaseDatabase.instance.ref('Post').child(SessionController().userId.toString()).child(uid);
    DatabaseReference userPostRef = FirebaseDatabase.instance.ref('Post').child(uid).child(SessionController().userId.toString());
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/chatImages/$id');
      firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);
      await Future.value(uploadTask).then((value) async{
        final newUrl = await storageRef.getDownloadURL();
        myPostRef.child(id).set({
          'message' : newUrl,
          'id' : id,
          'sender' : auth.currentUser!.email.toString()
        });
        userPostRef.child(id).set({
          'message' : newUrl,
          'id' : id,
          'sender' : auth.currentUser!.email.toString()
        });
      });
      notifyListeners();
    } else {
      Utils.toastMessage('No image selected');
    }
  }

  Future pickCameraImage(BuildContext context,String uid) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference myPostRef = FirebaseDatabase.instance.ref('Post').child(SessionController().userId.toString()).child(uid);
    DatabaseReference userPostRef = FirebaseDatabase.instance.ref('Post').child(uid).child(SessionController().userId.toString());
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/chatImages/$id');
      firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);
      await Future.value(uploadTask).then((value) async{
        final newUrl = await storageRef.getDownloadURL();
        myPostRef.child(id).set({
          'message' : newUrl,
          'id' : id,
          'sender' : auth.currentUser!.email.toString()
        });
        userPostRef.child(id).set({
          'message' : newUrl,
          'id' : id,
          'sender' : auth.currentUser!.email.toString()
        });
      });
      notifyListeners();
    } else {
      Utils.toastMessage('No image selected');
    }
  }



  void showPickOption(context,String uid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 122,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context,uid);

                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.photo_camera,
                      size: 40,
                    ),
                    title: Text(
                      'Camera',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      pickGallaryImage(context,uid);
                      // uploadImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.image,
                      size: 40,
                    ),
                    title: Text(
                      'Gallary',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
