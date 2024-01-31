class OrderResponseModel {
  List<String> orderList;
  int totalPrice;
  String timestamp;
  bool isOrderReady;
  int orderId;

  OrderResponseModel({
    required this.orderList,
    required this.totalPrice,
    required this.timestamp,
    required this.isOrderReady,
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderList': orderList,
      'totalPrice': totalPrice,
      'timestamp': timestamp,
      'isOrderReady': isOrderReady,
      'orderId': orderId,
    };
  }

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      orderList:
          (json['orderList'] as List<dynamic>).map((e) => e as String).toList(),
      totalPrice: json['totalPrice'] as int,
      timestamp: json['timestamp'] as String,
      isOrderReady: json['isOrderReady'] as bool,
      orderId: json['orderId'] as int,
    );
  }

  @override
  String toString() =>
      "OrderResponseModel(orderList: $orderList,totalPrice: $totalPrice,timestamp: $timestamp,isOrderReady: $isOrderReady,orderId: $orderId)";

  @override
  int get hashCode =>
      Object.hash(orderList, totalPrice, timestamp, isOrderReady, orderId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderResponseModel &&
          runtimeType == other.runtimeType &&
          orderList == other.orderList &&
          totalPrice == other.totalPrice &&
          timestamp == other.timestamp &&
          isOrderReady == other.isOrderReady &&
          orderId == other.orderId;
}
