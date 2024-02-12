import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'landing_viewmodel.g.dart';

class LandingViewModel = _LandingViewModelBase with _$LandingViewModel;

abstract class _LandingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  Future<int> init() async {
    WebSocketManager.instance.initializeSocketConnection();
    await localeManager.getSharedPreferencesInstance();
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
}
