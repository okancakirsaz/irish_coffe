import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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
  @observable
  String cardNumber = "1XXX XXXX XXXX XXXX";
  @observable
  String cardHolderName = "Kart Sahibi";
  @observable
  String expiryDate = "XX/XX";
  @observable
  String cvvCode = "XXX";
  @observable
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int calculateTotalPrice(List<int> prices) {
    priceList = prices;
    totalPrice = priceList.reduce((a, b) => a + b);
    return totalPrice;
  }

  Future<void> finishPayment() async {
    _navigateToFinalPage();
  }

  onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      debugPrint('valid! $cardNumber $cardHolderName $expiryDate $cvvCode');
    } else {
      debugPrint('invalid!');
    }
  }

  @action
  onCreditCardModelChange(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
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
