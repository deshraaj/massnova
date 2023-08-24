import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/contact_screen.dart';
import 'package:tech_media/view/dashboard/profile_screen.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';



class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteName.contactScreen:
        return MaterialPageRoute(builder: (_) => const ContactScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}