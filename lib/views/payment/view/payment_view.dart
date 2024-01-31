import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/views/payment/viewmodel/payment_viewmodel.dart';

import '../../../core/widgets/custom_statefull_button.dart';

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
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildCreditCard(model),
                  Text(
                    "Toplam ücret: ${model.calculateTotalPrice(priceList)}₺",
                    style: TextConsts.instance.regularWhite25,
                  ),
                  Padding(
                    padding: PaddingConsts.instance.all20,
                    child: buildInputs(model),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Ödeme Bilgilerinizi Giriniz",
                style: TextConsts.instance.regularWhite20Bold,
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

  Widget buildCreditCard(PaymentViewModel model) {
    return Observer(builder: (context) {
      return CreditCardWidget(
        cardNumber: model.cardNumber,
        obscureCardNumber: false,
        obscureCardCvv: false,
        isHolderNameVisible: true,
        obscureInitialCardNumber: false,
        expiryDate: model.expiryDate,
        cardBgColor: ColorConsts.instance.orange,
        cardHolderName: model.cardHolderName,
        cvvCode: model.cvvCode,
        showBackView: model.isCvvFocused,
        onCreditCardWidgetChange: (CreditCardBrand brand) {},
      );
    });
  }

  Widget buildInputs(PaymentViewModel model) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConsts.instance.lightGray,
          borderRadius: RadiusConsts.instance.circularAll10),
      padding: PaddingConsts.instance.all10,
      child: Column(
        children: <Widget>[
          CreditCardForm(
            disableCardNumberAutoFillHints: true,
            cvvValidationMessage: "Geçerli bir kod giriniz.",
            dateValidationMessage: "Geçerli bir tarih giriniz.",
            numberValidationMessage: "Geçerli bir kart numarası giriniz.",
            inputConfiguration: InputConfiguration(
              cardNumberDecoration:
                  buildInputDecorationForCardForm("Kart Numarası"),
              cardHolderDecoration:
                  buildInputDecorationForCardForm("Kart Sahibi"),
              expiryDateDecoration: buildInputDecorationForCardForm("SKT"),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cardNumber: model.cardNumber,
            expiryDate: model.expiryDate,
            cardHolderName: model.cardHolderName,
            cvvCode: model.cvvCode,
            onCreditCardModelChange: (CreditCardModel cardModel) =>
                model.onCreditCardModelChange(cardModel),
            formKey: model.formKey,
          ),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: CustomStateFullButton(
                onPressed: () async => await model.paymentGateway(),
                style: TextConsts.instance.regularBlack18Bold,
                text: "Onayla",
                width: 150,
                height: 50),
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecorationForCardForm(String label) {
    return InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.green),
        ),
        label: Text(
          label,
          style: TextConsts.instance.regularBlack18,
        ));
  }
}
