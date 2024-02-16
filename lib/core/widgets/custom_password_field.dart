import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:passwordfield/passwordfield.dart';

class CustomPasswordField extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final TextStyle style;
  final double height;
  const CustomPasswordField({
    super.key,
    this.padding,
    required this.controller,
    required this.height,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: PasswordField(
        backgroundColor: ColorConsts.instance.lightGray,
        hintText: null,
        color: Colors.black,
        errorMessage: "",
        passwordDecoration: PasswordDecoration(
            inputPadding: const EdgeInsets.only(left: 10), inputStyle: style),
        border: PasswordBorder(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
