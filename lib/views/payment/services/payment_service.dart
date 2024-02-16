import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/payment/models/order_request_model.dart';
import 'package:irish_coffe/views/payment/models/order_response_model.dart';
import 'package:irish_coffe/views/payment/models/payment_request_model.dart';
import 'package:irish_coffe/views/payment/models/payment_response_model.dart';

import '../../../core/consts/app_consts.dart';

class PaymentService extends NetworkManager {
  Future<PaymentResponseModel?> paymentGateway(PaymentRequestModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.payment, data: data.toJson());

      return PaymentResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<OrderResponseModel?> createOrder(OrderRequestModel data) async {
    try {
      final response = await network.post(AppConst.instance.createOrder,
          data: data.toJson());

      return OrderResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
