import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memo_app/providers/personal_info_provider.dart';

class FirstVisit extends StatelessWidget {
  const FirstVisit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Consumer<PersonalInfo>(
        builder: (context, value, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset('assets/memo.png'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '\n메모를 작성하고',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '알림으로 받아보세요\n\n\n',
                      style: TextStyle(fontSize: 30),
                    ),
                    // Text('first visit\n${value.isFirst}'),
                  ],
                ),
                TextButton(
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    value.visit();
                  },
                  child: const Text(
                    '시작하기',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
