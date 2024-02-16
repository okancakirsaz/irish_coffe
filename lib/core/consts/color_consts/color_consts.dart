import 'package:flutter/material.dart';

class ColorConsts {
  static final ColorConsts instance = ColorConsts();
  final Color lightGray = const Color(0xFFF4F4F4);
  final Color background = const Color(0xFFF4F4F4);
  final Color black = const Color(0xFF000000);
  final Color darkGrey = const Color(0xFF3E3E3E);
  final Color green = const Color.fromARGB(255, 7, 117, 14);
  final Color orange = Colors.orange;
  final Color red = const Color(0xFFE20707);
  final List<BoxShadow> shadow = [
    const BoxShadow(
      offset: Offset(5, 5),
      blurRadius: 5,
      color: Color(0x25000000),
    )
  ];
}
