import 'package:flutter/material.dart';

class Palette extends StatefulWidget {
  final Function(Color)? onChanged;
  final bool isDarkMode;
  const Palette({
    Key? key,
    required this.onChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _PaletteState createState() => _PaletteState();
}

class _PaletteState extends State<Palette> {
  Color currentValue = MemoColor.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Builder(builder: (_) {
          List<Widget> result = [];
          for (var element in MemoColor.cardColors) {
            result.add(
              checkBox(
                  selectedColor: currentValue,
                  borderColor:
                      (widget.isDarkMode) ? const Color(0xFFD6D6D6) : Colors.black,
                  color: element,
                  onPressed: () {
                    setState(() {
                      currentValue = element;
                    });
                    widget.onChanged!(currentValue);
                  }),
            );
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.center, children: result);
        }),
      ),
    );
  }
}

Widget checkBox({
  required Color color,
  required Color borderColor,
  required Color selectedColor,
  required void Function()? onPressed,
}) =>
    Container(
      margin: const EdgeInsets.all(3),
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.3,
              color: (color == selectedColor) ? Colors.blue : borderColor,
            ),
            borderRadius: BorderRadius.circular(20)),
        fillColor: color,
        constraints: const BoxConstraints.tightFor(width: 30, height: 30),
      ),
    );

class MemoColor {
  static List<Color> cardColors = [
    white,
    pink,
    yellow,
    green,
    blue,
    purple,
    grey,
    neonPink,
    neonOrange,
    neonYellow,
    neonGreen,
    neonMint,
    neonBlue,
    neonPurple
  ];
  static Color white = const Color(0xFFFFFFFF);
  static Color pink = const Color(0xFFFBDAD2);
  static Color yellow = const Color(0xFFFFECB2);
  static Color green = const Color(0xFFBAE4C7);
  static Color blue = const Color(0xFFBADDE5);
  static Color purple = const Color(0xFFC1BDE1);
  static Color grey = const Color(0xFFD4D4D4);
  static Color neonPink = const Color(0xFFF95DE1);
  static Color neonOrange = const Color(0xFFF2A85A);
  static Color neonYellow = const Color(0xFFF1E55A);
  static Color neonGreen = const Color(0xFF57E55A);
  static Color neonMint = const Color(0xFF5BF5E5);
  static Color neonBlue = const Color(0xFF0385E5);
  static Color neonPurple = const Color(0xFF8000FF);
  static Color darkAppBar = const Color(0xFF2E3136);
  static Color darkBackGround = const Color(0xFF1F1F1F);
}
