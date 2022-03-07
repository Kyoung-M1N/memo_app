import 'package:memo_app/providers/memo_info_provider.dart';
import 'package:memo_app/providers/personal_info_provider.dart';
import 'package:memo_app/widgets/palette.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemoSet extends StatefulWidget {
  const MemoSet({Key? key}) : super(key: key);

  @override
  State<MemoSet> createState() => _MemoSetState();
}

class _MemoSetState extends State<MemoSet> {
  String? title;
  String? mainText;
  String color = 'Color(0xffffffff)';
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo =
        Provider.of<PersonalInfo>(context, listen: false);
    MemoInfo memoInfo = Provider.of<MemoInfo>(context, listen: false);
    return Scaffold(
      backgroundColor:
          (personalInfo.isDarkMode) ? MemoColor.darkBackGround : Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor:
            (personalInfo.isDarkMode) ? MemoColor.darkBackGround : Colors.white,
        title: Text(
          '메모 추가',
          style: TextStyle(
              color: (personalInfo.isDarkMode) ? Colors.white : Colors.black),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: (personalInfo.isDarkMode) ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: TextField(
                  style: TextStyle(
                      color: (personalInfo.isDarkMode)
                          ? Colors.white
                          : Colors.black),
                  decoration: inputDecoration(
                      label: 'Title', isDarkMode: personalInfo.isDarkMode),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: TextField(
                  style: TextStyle(
                      color: (personalInfo.isDarkMode)
                          ? Colors.white
                          : Colors.black),
                  maxLines: 16,
                  decoration: inputDecoration(
                      label: 'Main text', isDarkMode: personalInfo.isDarkMode),
                  onChanged: (value) {
                    setState(() {
                      mainText = value;
                    });
                  },
                ),
              ),
              Palette(
                isDarkMode: personalInfo.isDarkMode,
                onChanged: (value) {
                  color = value.toString();
                },
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 16,
                  height: 200,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                                color: (personalInfo.isDarkMode)
                                    ? Colors.white
                                    : Colors.black))),
                    child: CupertinoDatePicker(onDateTimeChanged: (datetime) {
                      setState(() {
                        year = datetime.year;
                        month = datetime.month;
                        day = datetime.day;
                        hour = datetime.hour;
                        minute = datetime.minute;
                      });
                    }),
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextButton(
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory,
                      ),
                  onPressed: (title != null && mainText != null)
                      ? () {
                          String key = DateTime.now().year.toString() +
                              DateTime.now().month.toString() +
                              DateTime.now().day.toString() +
                              DateTime.now().hour.toString() +
                              DateTime.now().minute.toString() +
                              DateTime.now().second.toString();
                          memoInfo.addMemo(key, title!, mainText!, color, year,
                              month, day, hour, minute);
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('OK'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration inputDecoration({required label, required bool isDarkMode}) =>
    InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[400]),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            width: 1, color: (isDarkMode) ? Colors.white : Colors.black),
      ),
    );
