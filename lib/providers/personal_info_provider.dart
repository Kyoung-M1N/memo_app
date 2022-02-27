import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends ChangeNotifier {
  bool _isFirst = true;
  bool _isDarkMode = false;
  late String _name;

  bool get isFirst => _isFirst;
  bool get isDarkMode => _isDarkMode;
  String get name => _name;

  void visit() async {
    // _isFirst = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst', false);
    notifyListeners();
  }

  void reverse() async {
    // _isFirst = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst', true);
    notifyListeners();
  }

  void nameChange(String input) async {
    // _name = input;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
    notifyListeners();
  }

  void loadinfo() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirst = prefs.getBool('isFirst') ?? true;
    _name = prefs.getString('name') ?? 'none';
    notifyListeners();
  }

  void changeTheme(bool value){
    _isDarkMode = value;
    notifyListeners();
  }
}
