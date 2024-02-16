import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_scaffold.dart';
import 'package:irish_coffe/views/main/view/main_view.dart';

class OrderFinal extends StatelessWidget {
  final List<dynamic> orderDetails;
  final int orderId;
  final bool isOrderReady;
  const OrderFinal(
      {super.key,
      required this.orderDetails,
      required this.orderId,
      required this.isOrderReady});

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
                "Sipariş Numaranız: $orderId",
                style: TextConsts.instance.regularWhite25,
              ),
            ),
          ),
          Container(
            height: 200,
            padding: PaddingConsts.instance.all10,
            color: ColorConsts.instance.orange,
            child: ListView.builder(
                itemCount: orderDetails.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      "${orderDetails[index]["name"]} x${orderDetails[index]["count"]}",
                      style: TextConsts.instance.regularBlack20Bold,
                    ),
                  );
                }),
          ),
          Padding(
            padding: PaddingConsts.instance.all10,
            child: Text(
              isOrderReady
                  ? "Siparişiniz hazır."
                  : "Siparişiniz şu anda hazırlanıyor.",
              style: TextConsts.instance.regularBlack18,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MainView(),
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
