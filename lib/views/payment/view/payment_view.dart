import 'package:flutter/material.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/core/widgets/custom_text_field.dart';
import 'package:irish_coffe/views/payment/viewmodel/payment_viewmodel.dart';

class PaymentView extends StatelessWidget {
  final List<int> priceList;
  const PaymentView({super.key, required this.priceList});

  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentViewModel>(
        viewModel: PaymentViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            backgroundColor: ColorConsts.instance.green,
            body: Column(
              children: <Widget>[
                Text(
                  "Toplam ücret: ${model.calculateTotalPrice(priceList)}₺",
                  style: TextConsts.instance.regularBlack25,
                ),
                Padding(
                  padding: PaddingConsts.instance.all20,
                  child: Expanded(
                    flex: 10,
                    child: buildInputs(model),
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Ödeme Bilgilerinizi Giriniz",
                style: TextConsts.instance.regularBlack18Bold,
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
          model.priceList = priceList;
        },
        onDispose: () {});
  }

  Widget buildInputs(PaymentViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildTextFieldWithTitle(
          model.cardOwnerName,
          "Kart Üzerindeki İsim Soyisim",
        ),
        const SizedBox(height: 10),
        buildTextFieldWithTitle(
          model.cardNumber,
          "Kart Numarası",
          TextInputType.number,
        ),
        const SizedBox(height: 10),
        buildTextFieldWithTitle(
          model.cardDate,
          "Kart SKT",
          TextInputType.datetime,
        ),
        const SizedBox(height: 10),
        buildTextFieldWithTitle(
          model.cvc,
          "CVC",
          TextInputType.number,
        ),
        const SizedBox(height: 10),
        CustomButton(
          onPressed: () async => await model.finishPayment(),
          style: TextConsts.instance.regularBlack18Bold,
          text: "Onayla",
          width: 120,
          height: 50,
        )
      ],
    );
  }

  Widget buildTextFieldWithTitle(TextEditingController controller, String title,
      [TextInputType? type]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextConsts.instance.regularBlack18Bold,
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: controller,
          height: 50,
          inputType: type,
          style: TextConsts.instance.regularBlack18,
        ),
      ],
    );
  }
}
