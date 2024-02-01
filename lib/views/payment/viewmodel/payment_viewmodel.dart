import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/widgets/are_you_sure_dialog.dart';
import 'package:irish_coffe/views/menu/views/components/order_final.dart';
import 'package:irish_coffe/views/payment/models/order_request_model.dart';
import 'package:irish_coffe/views/payment/models/order_response_model.dart';
import 'package:irish_coffe/views/payment/models/payment_request_model.dart';
import 'package:irish_coffe/views/payment/models/payment_response_model.dart';
import 'package:irish_coffe/views/payment/services/payment_service.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'payment_viewmodel.g.dart';

class PaymentViewModel = _PaymentViewModelBase with _$PaymentViewModel;

abstract class _PaymentViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    _getLocaleCardData();
  }

  PaymentService service = PaymentService();
  List<int> priceList = [];
  late final int totalPrice;
  @observable
  String cardNumber = "";
  @observable
  String cardHolderName = "";
  @observable
  String expiryDate = "";
  @observable
  String cvvCode = "";
  @observable
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _getLocaleCardData() {
    cardNumber =
        localeManager.getNullableStringData(LocaleKeysEnums.cardNumber.name) ??
            "";

    cardHolderName =
        localeManager.getNullableStringData(LocaleKeysEnums.cardHolder.name) ??
            "";
    expiryDate = localeManager
            .getNullableStringData(LocaleKeysEnums.cardExpireDate.name) ??
        "";
    cvvCode =
        localeManager.getNullableStringData(LocaleKeysEnums.cvv.name) ?? "";
  }

  String initCardNumberInput() {
    return localeManager
            .getNullableStringData(LocaleKeysEnums.cardNumber.name) ??
        "";
  }

  int calculateTotalPrice(List<int> prices) {
    priceList = prices;
    totalPrice = priceList.reduce((a, b) => a + b);
    return totalPrice;
  }

  Future<void> paymentGateway() async {
    if (localeManager.getNullableStringData(LocaleKeysEnums.cardNumber.name) ==
        null) {
      await _openCardSaveDialog();
    }
    await _onValidate();
  }

  Future<void> _onValidate() async {
    if (formKey.currentState?.validate() ?? false) {
      final PaymentResponseModel? response = await service.paymentGateway(
        PaymentRequestModel(
            cardHolder: cardHolderName,
            cardNumber: cardNumber,
            expirationDate: expiryDate,
            ccv: cvvCode,
            price: totalPrice),
      );
      await _handlePaymentResponse(response);
    } else {}
  }

  Future<void> _handlePaymentResponse(PaymentResponseModel? response) async {
    if (response != null) {
      if (response.isSuccess) {
        await _createOrder();
      } else {
        Fluttertoast.showToast(msg: response.errorMessage!);
      }
    } else {
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz.");
    }
  }

  Future<void> _createOrder() async {
    final OrderResponseModel? response = await service.createOrder(
      OrderRequestModel(
          orderList:
              localeManager.getJsonData(LocaleKeysEnums.orderedFoods.name),
          totalPrice: totalPrice,
          timestamp: DateTime.now().toIso8601String(),
          userId: localeManager.getStringData(LocaleKeysEnums.userId.name)),
    );

    if (response != null) {
      _navigateToFinalPage(response);
    }
  }

  Future<void> _openCardSaveDialog() async {
    await showDialog(
        context: viewModelContext,
        builder: (context) => AreYouSure(
              onPressed: _saveLocalToCardData,
              question: "Kart bilgileri kaydedilsin mi?",
            ));
  }

  Future<void> _saveLocalToCardData() async {
    await localeManager.setStringData(
        LocaleKeysEnums.cardHolder.name, cardHolderName);
    await localeManager.setStringData(
        LocaleKeysEnums.cardExpireDate.name, expiryDate);
    await localeManager.setStringData(
        LocaleKeysEnums.cardNumber.name, cardNumber);
    await localeManager.setStringData(LocaleKeysEnums.cvv.name, cvvCode);
    _navigatorPop();
  }

  _navigatorPop() {
    Navigator.pop(viewModelContext);
  }

  @action
  onCreditCardModelChange(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
  }

  _navigateToFinalPage(OrderResponseModel data) {
    //TODO: Use navigation manager
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      CupertinoPageRoute(
        builder: (context) => OrderFinal(
          orderDetails: data.orderList,
          orderId: data.orderId,
          isOrderReady: data.isOrderReady,
        ),
      ),
      (route) => false,
    );
  }
}
