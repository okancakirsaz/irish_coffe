import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/views/menu/views/components/order_final.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'payment_viewmodel.g.dart';

class PaymentViewModel = _PaymentViewModelBase with _$PaymentViewModel;

abstract class _PaymentViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {}

  List<int> priceList = [];
  late final int totalPrice;
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController cardOwnerName = TextEditingController();
  final TextEditingController cardDate = TextEditingController();
  final TextEditingController cvc = TextEditingController();

  int calculateTotalPrice(List<int> prices) {
    priceList = prices;
    totalPrice = priceList.reduce((a, b) => a + b);
    return totalPrice;
  }

  Future<void> finishPayment() async {
    _navigateToFinalPage();
  }

  _navigateToFinalPage() {
    //TODO: Use navigation manager
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      CupertinoPageRoute(
        builder: (context) => const OrderFinal(),
      ),
      (route) => false,
    );
  }
}
