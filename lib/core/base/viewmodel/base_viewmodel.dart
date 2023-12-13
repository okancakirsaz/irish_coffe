import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_manager.dart';
import 'package:irish_coffe/core/service/mock_services/login_mock_services.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

import '../../consts/asset_consts.dart';
import '../../init/cache/local_keys_enums.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  void init() {}
  Future<String> pickImageForGender([String? userToken]) async {
    String? gender;
    if (userToken == null) {
      gender = localeManager.getNullableStringData(LocaleKeysEnums.gender.name);
    } else {
      //TODO: Deprecate dependency injection
      final UserDataModel user =
          await LoginMockServices.findUserFromToken(userToken);
      gender = user.gender;
    }

    if (gender == "Kadın") {
      return AssetConsts.instance.woman;
    } else {
      return AssetConsts.instance.man;
    }
  }
}
