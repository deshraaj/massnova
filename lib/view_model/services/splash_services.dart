import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../view/dashboard/users_screen.dart';

class SplashServices {
String userName = '';
String profile = '';
  Future getData()async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(SessionController().userId.toString());

// Get the data once
    DatabaseEvent event = await ref.once();
    userName = event.snapshot.child('userName').value.toString();
    profile = event.snapshot.child('profile').value.toString();
  }

  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
      getData();

      Timer(const Duration(seconds: 3),
          (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen())));

            Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersScreen(userName: userName, profile: profile)));

              });
    } else {
      Timer(const Duration(seconds: 3),
          () =>
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()))
              Navigator.pushNamed(context, RouteName.loginScreen)
      );
    }
  }
}
