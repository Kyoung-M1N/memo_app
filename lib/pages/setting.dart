import 'package:memo_app/providers/personal_info_provider.dart';
import 'package:memo_app/widgets/palette.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = Provider.of<PersonalInfo>(context);
    return Scaffold(
      backgroundColor:
          (personalInfo.isDarkMode) ? MemoColor.darkBackGround : Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor:
            (personalInfo.isDarkMode) ? MemoColor.darkAppBar : Colors.white,
        title: Text(
          '설정',
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              '다크테마 적용',
              style: TextStyle(
                  color:
                      (personalInfo.isDarkMode) ? Colors.white : Colors.black),
            ),
            trailing: CupertinoSwitch(
                activeColor: Colors.blue,
                value: personalInfo.isDarkMode,
                onChanged: (value) {
                  personalInfo.changeTheme(value);
                }),
          ),
        ],
      ),
    );
  }
}
