import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';

class AreYouSure extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onCancelPressed;
  final String? question;
  final double? height;
  const AreYouSure(
      {super.key,
      required this.onPressed,
      this.question,
      this.height,
      this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConsts.instance.darkGrey,
      content: SizedBox(
        height: height ?? 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              question ?? "Emin misiniz? ",
              style: TextConsts.instance.regularWhite20Bold,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildSpecialButton(onPressed, "Evet"),
                buildSpecialButton(
                    onCancelPressed ?? () => Navigator.pop(context), "Hayır"),
              ],
            )
          ],
        ),
      ),
    );
  }

  //TODO: Make the button as seperated widget
  Widget buildSpecialButton(VoidCallback onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(ColorConsts.instance.orange),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: RadiusConsts.instance.circularAll10),
        ),
      ),
      child: Text(
        text,
        style: TextConsts.instance.regularWhite16Bold,
      ),
    );
  }
}
