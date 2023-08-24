


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view/dashboard/users_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../utils/utils.dart';

class LoginController with ChangeNotifier{

  bool _loading = false;

  bool get loading => _loading;
  FirebaseAuth auth = FirebaseAuth.instance;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future getData(context)async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(SessionController().userId.toString());

// Get the data once
    DatabaseEvent event = await ref.once();
    String userName = event.snapshot.child('userName').value.toString();
    String profile = event.snapshot.child('profile').value.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersScreen(userName: userName, profile: profile)));
  }

  void login(BuildContext context, String email, String password) {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Utils.toastMessage('loggedIn successfully');
        getData(context);
        // Navigator.pushNamed(context, RouteName.dashboardScreen);
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