import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memo_app/providers/memo_info_provider.dart';

class MemoList extends StatelessWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoInfo>(
      builder: (context, value, child) {
        return (value.memos.isEmpty)
            ? const Center(child: Text('아직 메모가 없습니다'))
            : Builder(
                builder: (context) {
                  List<Widget> memosList1 = [];
                  List<Widget> memosList2 = [];
                  value.memos.forEach(
                    (key, value) {
                      if (memosList2.length == memosList1.length) {
                        memosList1.add(memo(context: context, memo: value));
                      } else {
                        memosList2.add(memo(context: context, memo: value));
                      }
                    },
                  );

                  return Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: memosList1),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: memosList2),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}

Widget memo({required context, required Memo memo}) {
  MemoInfo memoInfo = Provider.of<MemoInfo>(context);
  bool isSelected = false;
  return Container(
    padding: const EdgeInsets.all(5),
    width: (MediaQuery.of(context).size.width / 2) - 8,
    height: (MediaQuery.of(context).size.width / 2) - 8,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        if (memoInfo.deleteMode == true) {
          isSelected = (isSelected) ? false : true;
          // print(isSelected);
          memoInfo.removeMemo(memo.key);
        } else {
          showDialog(
            barrierColor: Colors.white54,
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return memoDetail(context: context, memo: memo);
              });
        }
      },
      child: Card(
        color: Color(int.parse(memo.color.substring(6, 16))),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                memo.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                memo.mainText,
                maxLines: 9,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

AlertDialog memoDetail({required context, required Memo memo}) {
  return AlertDialog(
    backgroundColor: Color(int.parse(memo.color.substring(6, 16))),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Text(memo.title),
    content: Text(memo.mainText +
        '\n\n' +
        memo.year.toString() + '/' +
        memo.month.toString() + '/' +
        memo.day.toString() + '-' +
        memo.hour.toString() + ':' +
        memo.minute.toString()),
    actions: [
      TextButton(
          onPressed: () => Navigator.pop(context), child: const Text('확인'))
    ],
  );
}
