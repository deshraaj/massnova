import 'package:flutter/material.dart';


class ChangeThemeMode with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;


  void changeTheme(ThemeMode currentTheme){
    _themeMode = currentTheme;
    notifyListeners();
  }
  void refresh(){
    notifyListeners();
  }

}

