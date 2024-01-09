import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/radius_consts.dart';
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
                    child: Expanded(
                      flex: 10,
                      child: buildInputs(model),
                    ),
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
            cardNumber: "",
            expiryDate: "",
            cardHolderName: "",
            cvvCode: "",
            onCreditCardModelChange: (CreditCardModel cardModel) =>
                model.onCreditCardModelChange(cardModel),
            formKey: model.formKey,
          ),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: CustomButton(
                onPressed: () => model.onValidate(),
                style: TextConsts.instance.regularBlack18Bold,
                text: "Onayla",
                width: 150,
                height: 50),
          )
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
