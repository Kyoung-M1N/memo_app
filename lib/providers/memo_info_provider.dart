import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class MemoInfo extends ChangeNotifier {
  Map<String, Memo> memos = {};
  bool deleteMode = false;

  void addMemo(String key, String title, String mainText, String color,
      int year, int month, int day, int hour, int minute) async {
    memos.addAll({
      key: Memo(
          key: key,
          title: title,
          mainText: mainText,
          color: color,
          year: year,
          month: month,
          day: day,
          hour: hour,
          minute: minute)
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('keys', memos.keys.toList());
    await prefs.setStringList(key, [
      title,
      mainText,
      color,
      year.toString(),
      month.toString(),
      day.toString(),
      hour.toString(),
      minute.toString()
    ]);
    notifyListeners();
  }

  void removeMode() {
    if (deleteMode == false) {
      deleteMode = true;
    } else {
      deleteMode = false;
    }
  }

  void removeMemo(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    memos.remove(key);
    await prefs.setStringList('keys', memos.keys.toList());
    notifyListeners();
  }

  void loadMemo() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? keys = prefs.getStringList('keys');
    if (keys != null) {
      for (int i = 0; i < keys.length; i++) {
        List<String>? temp = prefs.getStringList(keys[i]);
        memos.addAll({
          keys[i]: Memo(
              key: keys[i],
              title: temp![0],
              mainText: temp[1],
              color: temp[2],
              year: int.parse(temp[3]),
              month: int.parse(temp[4]),
              day: int.parse(temp[5]),
              hour: int.parse(temp[6]),
              minute: int.parse(temp[7]))
        });
      }
    }
  }
}

class Memo {
  late String key;
  late String title;
  late String mainText;
  late String color;
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;

  Memo(
      {required this.key,
      required this.title,
      required this.mainText,
      required this.color,
      required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.minute});
}
