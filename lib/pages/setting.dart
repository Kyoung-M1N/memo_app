import 'package:memo_app/providers/personal_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = Provider.of<PersonalInfo>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          '설정',
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
      body: ListView(
        children: [
          ListTile(
            title: const Text('다크테마 적용'),
            trailing: CupertinoSwitch(
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
