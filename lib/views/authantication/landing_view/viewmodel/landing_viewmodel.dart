import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/views/authantication/landing_view/services/landing_services.dart';
import 'package:irish_coffe/views/profile/models/boolean_single_response_model.dart';
import 'package:irish_coffe/views/profile/models/user_id_send_request_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/init/navigation/navigation_enums.dart';
import '../../../../core/init/navigation/navigation_manager.dart';

part 'landing_viewmodel.g.dart';

class LandingViewModel = _LandingViewModelBase with _$LandingViewModel;

abstract class _LandingViewModelBase with Store, BaseViewModel {
  final LandingServices services = LandingServices();

  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  Future<int> init() async {
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
      bool isUserBanned = await checkIsUserBanned(userId);
      if (!isUserBanned) {
        //TODO: Same logic in profile_viewmodel with same functions move they to new auth viewmodel
        await logOut();
      }
    }
  }

  Future<bool> checkIsUserBanned(String userId) async {
    final BooleanSingleResponseModel? response =
        await services.checkIsUserBanned(UserIdSendRequestModel(uid: userId));

    if (response != null) {
      //if isSuccess false user got banned
      return response.isSuccess!;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    await clearCache();
    navigateToLoginPage();
  }

  Future<void> clearCache() async {
    try {
      await localeManager.removeData(LocaleKeysEnums.name.name);
      await localeManager.removeData(LocaleKeysEnums.mail.name);
      await localeManager.removeData(LocaleKeysEnums.token.name);
      await localeManager.removeData(LocaleKeysEnums.profileImage.name);
      await localeManager.removeData(LocaleKeysEnums.isUserAnonym.name);
      await localeManager.removeData(LocaleKeysEnums.userId.name);
    } catch (e) {
      //TODO: Add crashlytics
    }
  }

  navigateToLoginPage() {
    NavigationManager.instance
        .removeUntil(NavigationEnums.LOGIN, viewModelContext);
  }
}
