import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  final picker = ImagePicker();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  XFile? _image;

  XFile? get image => _image;

  Future pickGallaryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref(SessionController().userId.toString());
      firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);
      await Future.value(uploadTask).then((value) async{
        final newUrl = await storageRef.getDownloadURL();
        ref.child(SessionController().userId.toString()).update({
          'profile' : newUrl.toString()
        }).then((value){
          Utils.toastMessage('profile Updated');
        }).onError((error, stackTrace){
          Utils.toastMessage(error.toString());
        }).onError((error, stackTrace){
          Utils.toastMessage(error.toString());
        });
      });
      notifyListeners();
    } else {
      Utils.toastMessage('No image selected');
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref(SessionController().userId.toString());
      firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);
      await Future.value(uploadTask).then((value) async{
        final newUrl = await storageRef.getDownloadURL();
        ref.child(SessionController().userId.toString()).update({
          'profile' : newUrl.toString()
        }).then((value){
          Utils.toastMessage('profile Updated');
        }).onError((error, stackTrace){
          Utils.toastMessage(error.toString());
        }).onError((error, stackTrace){
          Utils.toastMessage(error.toString());
        });
      });
      notifyListeners();
    } else {
      Utils.toastMessage('No image selected');
    }
  }

  Future updateData(BuildContext context,String userName) async{


      await ref.child(SessionController().userId.toString()).update({
        'userName' : userName
      }).then((value){
        Utils.toastMessage('User Data Updated Successfully');
      }).onError((error, stackTrace){
        Utils.toastMessage(error.toString());
      });

notifyListeners();
  }


  void showPickOption(context) {
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
                      pickCameraImage(context);

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
                      pickGallaryImage(context);
                      // uploadImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.image,
                      size: 40,
                    ),
                    title: Text(
                      'Gallery',
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
