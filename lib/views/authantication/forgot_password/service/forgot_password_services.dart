import 'package:flutter/foundation.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_request_model.dart';
import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_response_model.dart';

final class ForgotPasswordServices extends NetworkManager {
  Future<ForgotPasswordResponseModel?> postEmailData(
      ForgotPasswordRequestModel data) async {
    try {
      final response =
          await network.post("/forgot-password", data: data.toJson());
      return ForgotPasswordResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
