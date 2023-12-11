import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/views/menu/views/menu_view.dart';

class OrderFinal extends StatelessWidget {
  const OrderFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              padding: PaddingConsts.instance.all10,
              margin: PaddingConsts.instance.all10,
              decoration: BoxDecoration(
                color: ColorConsts.instance.green,
                borderRadius: RadiusConsts.instance.circularAll10,
                boxShadow: ColorConsts.instance.shadow,
              ),
              child: Text(
                "Sipariş Numaranız: 10",
                style: TextConsts.instance.regularWhite25,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MenuView(),
                ),
                (route) => false,
              );
            },
            child: Text(
              "Menü sayfasına geri dön",
              style: TextConsts.instance.regularBlack20Underlined,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Teşekkürler, siparişiniz alınmıştır.",
          style: TextConsts.instance.regularBlack18Bold,
        ),
      ),
    );
  }
}
