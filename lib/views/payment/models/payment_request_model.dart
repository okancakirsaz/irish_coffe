class PaymentRequestModel {
  String cardHolder;
  String cardNumber;
  String expirationDate;
  String ccv;
  int price;

  PaymentRequestModel({
    required this.cardHolder,
    required this.cardNumber,
    required this.expirationDate,
    required this.ccv,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'ccv': ccv,
      'price': price,
    };
  }

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      cardHolder: json['cardHolder'] as String,
      cardNumber: json['cardNumber'] as String,
      expirationDate: json['expirationDate'] as String,
      ccv: json['ccv'] as String,
      price: json['price'] as int,
    );
  }

  @override
  String toString() =>
      "PaymentRequestModel(cardHolder: $cardHolder,cardNumber: $cardNumber,expirationDate: $expirationDate,ccv: $ccv,price: $price)";

  @override
  int get hashCode =>
      Object.hash(cardHolder, cardNumber, expirationDate, ccv, price);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentRequestModel &&
          runtimeType == other.runtimeType &&
          cardHolder == other.cardHolder &&
          cardNumber == other.cardNumber &&
          expirationDate == other.expirationDate &&
          ccv == other.ccv &&
          price == other.price;
}
