import 'package:flutter/material.dart';
import 'package:memo_app/pages/memo_set.dart';
import 'package:memo_app/providers/memo_info_provider.dart';
import 'package:memo_app/widgets/memo_list.dart';
import 'package:provider/provider.dart';
import 'package:memo_app/providers/personal_info_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MemoInfo memoInfo = Provider.of<MemoInfo>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'M E M O',
          style: TextStyle(color: Colors.black),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
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
              color: (memoInfo.deleteMode == false) ? Colors.black : Colors.red,
            ),
            onPressed: () {
              setState(() {
                if (memoInfo.deleteMode == false) {
                  memoInfo.removeMode();
                } else {
                  memoInfo.removeMemo('test', 'test');
                }
              });
            },
          )
        ],
      ),
      drawer: Consumer<PersonalInfo>(
        builder: (context, value, child) {
          return Drawer(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.backspace),
                  title: const Text('Go to First'),
                  onTap: () {
                    value.reverse();
                  },
                )
              ],
            ),
          );
        },
      ),
      body: const MemoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MemoSet()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
