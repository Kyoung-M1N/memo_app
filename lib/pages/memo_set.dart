import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:memo_app/providers/memo_info_provider.dart';
import 'package:memo_app/widgets/palette.dart';
import 'package:provider/provider.dart';

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
    MemoInfo memoInfo = Provider.of<MemoInfo>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          '메모 추가',
          style: TextStyle(color: Colors.black),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
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
                  decoration: inputDecoration(label: 'Title'),
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
                  maxLines: 16,
                  decoration: inputDecoration(label: 'Main text'),
                  onChanged: (value) {
                    setState(() {
                      mainText = value;
                    });
                  },
                ),
              ),
              Palette(
                onChanged: (value) {
                  color = value.toString();
                  // print();
                },
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 16,
                  height: 200,
                  child: CupertinoDatePicker(onDateTimeChanged: (datetime) {
                    setState(() {
                      year = datetime.year;
                      month = datetime.month;
                      day = datetime.day;
                      hour = datetime.hour;
                      minute = datetime.minute;
                    });
                  })),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextButton(
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
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

InputDecoration inputDecoration({required label}) => InputDecoration(
      labelText: label,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.blue),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1),
      ),
    );
