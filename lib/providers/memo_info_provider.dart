import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class MemoInfo extends ChangeNotifier {
  Map<String, Memo> memos = {};
  bool deleteMode = false;

  void addMemo(String title, String mainText, int year, int month, int day,
      int hour, int minute) async {
    memos.addAll({
      title: Memo(
          title: title,
          mainText: mainText,
          year: year,
          month: month,
          day: day,
          hour: hour,
          minute: minute)
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('keys', memos.keys.toList());
    await prefs.setStringList(title, [
      mainText,
      year.toString(),
      month.toString(),
      day.toString(),
      hour.toString(),
      minute.toString()
    ]);
    notifyListeners();
  }

  void removeMode() {
    deleteMode = true;
  }

  void removeMemo(String key, String title) async {
    final prefs = await SharedPreferences.getInstance();
    deleteMode = false;
  }

  void loadMemo() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? keys = prefs.getStringList('keys');
    if (keys != null) {
      for (int i = 0; i < keys.length; i++) {
        List<String>? temp = prefs.getStringList(keys[i]);
        memos.addAll({
          keys[i]: Memo(
              title: keys[i],
              mainText: temp![0],
              year: int.parse(temp[1]),
              month: int.parse(temp[2]),
              day: int.parse(temp[3]),
              hour: int.parse(temp[4]),
              minute: int.parse(temp[5]))
        });
      }
    }
  }

  @override
  notifyListeners();
}

class Memo {
  late String title;
  late String mainText;
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;

  Memo(
      {required this.title,
      required this.mainText,
      required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.minute});
}
