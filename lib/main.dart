import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/memo_info_provider.dart';
import 'providers/personal_info_provider.dart';
import 'pages/first_visit.dart';
import 'pages/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PersonalInfo()),
        ChangeNotifierProvider(create: (context) => MemoInfo()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showSemanticsDebugger:true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer2<PersonalInfo, MemoInfo>(
        builder: (context, personalInfo, memoInfo, child) {
          personalInfo.loadinfo();
          memoInfo.loadMemo();
          return (personalInfo.isFirst == true)
              ? const FirstVisit()
              : const Home();
        },
      ),
    );
  }
}