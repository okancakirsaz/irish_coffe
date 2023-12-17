import 'package:flutter/material.dart';
import 'package:irish_coffe/core/widgets/custom_password_field.dart';

import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/text_consts.dart';

class AuthTextFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  const AuthTextFieldPassword({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
        padding: PaddingConsts.instance.horizontal30,
        controller: controller,
        height: 50,
        style: TextConsts.instance.regularBlack18);
  }
}
