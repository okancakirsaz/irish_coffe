import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/profile/models/boolean_single_response_model.dart';
import 'package:irish_coffe/views/profile/models/user_id_send_request_model.dart';

import '../../../../core/consts/app_consts.dart';

final class LandingServices extends NetworkManager {
  Future<BooleanSingleResponseModel?> checkIsUserBanned(
      UserIdSendRequestModel data) async {
    try {
      final response = await network.post(AppConst.instance.checkIsUserBanned,
          data: data.toJson());
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
