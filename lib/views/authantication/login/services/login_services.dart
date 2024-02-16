import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/authantication/login/models/login_request_model.dart';

final class LoginServices extends NetworkManager {
  Future<UserDataModel?> sendLoginRequest(LoginRequestModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.logIn, data: data.toJson());
      return UserDataModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
