// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaymentViewModel on _PaymentViewModelBase, Store {
  late final _$cardNumberAtom =
      Atom(name: '_PaymentViewModelBase.cardNumber', context: context);

  @override
  String get cardNumber {
    _$cardNumberAtom.reportRead();
    return super.cardNumber;
  }

  @override
  set cardNumber(String value) {
    _$cardNumberAtom.reportWrite(value, super.cardNumber, () {
      super.cardNumber = value;
    });
  }

  late final _$cardHolderNameAtom =
      Atom(name: '_PaymentViewModelBase.cardHolderName', context: context);

  @override
  String get cardHolderName {
    _$cardHolderNameAtom.reportRead();
    return super.cardHolderName;
  }

  @override
  set cardHolderName(String value) {
    _$cardHolderNameAtom.reportWrite(value, super.cardHolderName, () {
      super.cardHolderName = value;
    });
  }

  late final _$expiryDateAtom =
      Atom(name: '_PaymentViewModelBase.expiryDate', context: context);

  @override
  String get expiryDate {
    _$expiryDateAtom.reportRead();
    return super.expiryDate;
  }

  @override
  set expiryDate(String value) {
    _$expiryDateAtom.reportWrite(value, super.expiryDate, () {
      super.expiryDate = value;
    });
  }

  late final _$cvvCodeAtom =
      Atom(name: '_PaymentViewModelBase.cvvCode', context: context);

  @override
  String get cvvCode {
    _$cvvCodeAtom.reportRead();
    return super.cvvCode;
  }

  @override
  set cvvCode(String value) {
    _$cvvCodeAtom.reportWrite(value, super.cvvCode, () {
      super.cvvCode = value;
    });
  }

  late final _$isCvvFocusedAtom =
      Atom(name: '_PaymentViewModelBase.isCvvFocused', context: context);

  @override
  bool get isCvvFocused {
    _$isCvvFocusedAtom.reportRead();
    return super.isCvvFocused;
  }

  @override
  set isCvvFocused(bool value) {
    _$isCvvFocusedAtom.reportWrite(value, super.isCvvFocused, () {
      super.isCvvFocused = value;
    });
  }

  late final _$_PaymentViewModelBaseActionController =
      ActionController(name: '_PaymentViewModelBase', context: context);

  @override
  dynamic onCreditCardModelChange(CreditCardModel creditCardModel) {
    final _$actionInfo = _$_PaymentViewModelBaseActionController.startAction(
        name: '_PaymentViewModelBase.onCreditCardModelChange');
    try {
      return super.onCreditCardModelChange(creditCardModel);
    } finally {
      _$_PaymentViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cardNumber: ${cardNumber},
cardHolderName: ${cardHolderName},
expiryDate: ${expiryDate},
cvvCode: ${cvvCode},
isCvvFocused: ${isCvvFocused}
    ''';
  }
}
