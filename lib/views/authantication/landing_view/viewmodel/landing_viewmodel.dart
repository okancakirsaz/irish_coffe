import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/public_managers/log_out_manager.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../profile/models/boolean_single_response_model.dart';
import '../../../profile/models/user_id_send_request_model.dart';
import '../services/landing_services.dart';

part 'landing_viewmodel.g.dart';

class LandingViewModel = _LandingViewModelBase with _$LandingViewModel;

abstract class _LandingViewModelBase with Store, BaseViewModel {
  //VARIABLES
  final LandingServices services = LandingServices();
  LogOutManager get logOutManager => LogOutManager(viewModelContext);

  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  Future<int> init() async {
    WebSocketManager.instance.initializeSocketConnection();
    await localeManager.getSharedPreferencesInstance();
    await isUserPassedBanSystem();
    await localeManager.removeData(LocaleKeysEnums.profileImage.name);
    return 1;
  }

  bool isCacheHaveToken() {
    final String? tokenData =
        localeManager.getNullableStringData(LocaleKeysEnums.token.name);
    if (tokenData != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> isUserPassedBanSystem() async {
    String? userId =
        localeManager.getNullableStringData(LocaleKeysEnums.userId.name);
    if (userId != null) {
      bool isUserBanned = await _checkIsUserBanned(userId);
      if (!isUserBanned) {
        await logOutManager.logOut();
      }
    }
  }

  Future<bool> _checkIsUserBanned(String userId) async {
    final BooleanSingleResponseModel? response =
        await services.checkIsUserBanned(UserIdSendRequestModel(uid: userId));

    if (response != null) {
      //if isSuccess false user got banned
      return response.isSuccess!;
    } else {
      return false;
    }
  }
}
