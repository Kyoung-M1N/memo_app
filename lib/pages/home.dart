import 'package:memo_app/pages/setting.dart';
import 'package:memo_app/providers/personal_info_provider.dart';
import 'package:memo_app/providers/memo_info_provider.dart';
import 'package:memo_app/widgets/memo_list.dart';
import 'package:memo_app/pages/memo_set.dart';
import 'package:memo_app/widgets/palette.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    PersonalInfo personalInfo = Provider.of<PersonalInfo>(context);
    MemoInfo memoInfo = Provider.of<MemoInfo>(context);
    return Scaffold(
      backgroundColor:
          (personalInfo.isDarkMode) ? MemoColor.darkBackGround : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            (personalInfo.isDarkMode) ? MemoColor.darkAppBar : Colors.white,
        title: Text(
          'M E M O',
          style: TextStyle(
              color: (personalInfo.isDarkMode) ? Colors.white : Colors.black),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: (personalInfo.isDarkMode) ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: (memoInfo.deleteMode == false)
                  ? (personalInfo.isDarkMode)
                      ? Colors.white
                      : Colors.black
                  : Colors.red,
            ),
            onPressed: () {
              setState(() {
                memoInfo.removeMode();
              });
            },
          )
        ],
      ),
      drawer: Consumer<PersonalInfo>(
        builder: (context, value, child) {
          return Drawer(
            backgroundColor:
                (personalInfo.isDarkMode) ? MemoColor.darkAppBar : Colors.white,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.backspace,
                    color: (personalInfo.isDarkMode)
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                  title: Text(
                    'Go to First',
                    style: TextStyle(
                      color: (personalInfo.isDarkMode)
                          ? Colors.white
                          : Colors.grey[700],
                    ),
                  ),
                  onTap: () {
                    value.reverse();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: (personalInfo.isDarkMode)
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                  title: Text(
                    '설정',
                    style: TextStyle(
                      color: (personalInfo.isDarkMode)
                          ? Colors.white
                          : Colors.grey[700],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const Setting()));
                  },
                )
              ],
            ),
          );
        },
      ),
      body: const MemoList(),
      floatingActionButton: (memoInfo.deleteMode)
          ? null
          : FloatingActionButton(
              backgroundColor: (personalInfo.isDarkMode)
                  ? MemoColor.darkAppBar
                  : Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const MemoSet()));
              },
              child: Icon(
                Icons.add,
                color: (personalInfo.isDarkMode) ? Colors.white : Colors.black,
              ),
            ),
    );
  }
}
