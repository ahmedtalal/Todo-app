import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light ,
  primarySwatch: Colors.indigo ,
  accentColor: Colors.pink ,
  primaryColor: Colors.red ,
  scaffoldBackgroundColor: Colors.white
) ;

ThemeData dark = ThemeData(
  brightness: Brightness.dark ,
  primarySwatch: Colors.indigo ,
  primaryColor: Colors.blue,
  accentColor: Colors.pink ,
);

class ThemeNotifier extends ChangeNotifier{
  final String _key = "themeMode" ;
  SharedPreferences _sharedPreferences ;
  bool _darkTheme  ;

  ThemeNotifier(){
    _darkTheme = false ;
    _loadFromPref() ;
  }

  bool get darhTheme => _darkTheme ;

  setTheme(){
    _darkTheme = !_darkTheme ;
    _savePref() ;
    notifyListeners() ;
  }

  _initPref() async{
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance() ;
    }
    return _sharedPreferences ;
  }

  _loadFromPref() async{
    await _initPref() ;
    _darkTheme = _sharedPreferences.getBool(_key) ?? false ;
    notifyListeners() ;
  }

  _savePref() async{
    await _initPref() ;
    _sharedPreferences.setBool(_key, _darkTheme) ;
  }
}