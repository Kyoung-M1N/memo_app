import 'package:flutter/material.dart';

class Palette extends StatefulWidget {
  final Function(Color)? onChanged;
  const Palette({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PaletteState createState() => _PaletteState();
}

class _PaletteState extends State<Palette> {
  Color? currentValue;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      checkBox(
          color: MemoColor.white,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.white;
            });
            widget.onChanged!(currentValue!);
          }),
      checkBox(color: MemoColor.pink,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.pink;
            });
            widget.onChanged!(currentValue!);
          }),
      checkBox(color: MemoColor.yellow,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.yellow;
            });
            widget.onChanged!(currentValue!);
          }),
      checkBox(color: MemoColor.green,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.green;
            });
            widget.onChanged!(currentValue!);
          }),
      checkBox(color: MemoColor.blue,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.blue;
            });
            widget.onChanged!(currentValue!);
          }),
      checkBox(color: MemoColor.purple,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.purple;
            });
            widget.onChanged!(currentValue!);
          }),
      checkBox(color: MemoColor.grey,
          onPressed: () {
            setState(() {
              currentValue = MemoColor.grey;
            });
            widget.onChanged!(currentValue!);
          }),
    ]);
  }
}

Widget checkBox({
  required Color color,
  required void Function()? onPressed,
  
}) =>
    Container(
      margin: EdgeInsets.all(3),
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20)),
        fillColor: color,
        constraints: BoxConstraints.tightFor(width: 30, height: 30),
      ),
    );

class MemoColor{
  static Color pink = const Color(0xFFFBDAD2);
  static Color yellow = const Color(0xFFFFECB2);
  static Color green = const Color(0xFFBAE4C7);
  static Color blue = const Color(0xFFBADDE5);
  static Color purple = const Color(0xFFC1BDE1);
  static Color grey = const Color(0xFFD4D4D4);
  static Color white = const Color(0xFFFFFFFF);
}