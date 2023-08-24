import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tech_media/view/dashboard/users_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SignUpController with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void singup(
      BuildContext context, String username, String email, String password,String phoneNumber) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'userName': username,
          'online': 'noOne',
          'phone': phoneNumber,
          'profile': '',
        }).then((value) {
          setLoading(false);
          Utils.toastMessage('account created successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersScreen(userName: username, profile: '')));
          // Navigator.pushNamed(context, RouteName.dashboardScreen);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        });
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
