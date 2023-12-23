import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

final class SignUpServices extends NetworkManager {
  Future<UserDataModel?> sendSignUpRequest(UserDataModel data) async {
    try {
      final response = await network.post("/sign-up", data: data.toJson());
      return UserDataModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
