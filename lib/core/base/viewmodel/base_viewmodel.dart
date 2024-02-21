import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/cache/local_manager.dart';

import '../../consts/asset_consts.dart';
import '../../init/cache/local_keys_enums.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  void init() {}
  final ScrollController defaultScrollController = ScrollController();
  navigatorPop() {
    if (Navigator.of(viewModelContext).canPop()) {
      Navigator.pop(viewModelContext);
    }
  }

  Future<void> removeGameDataCache() async {
    await localeManager.removeData(LocaleKeysEnums.isUserInTheGame.name);
    await localeManager.removeData(LocaleKeysEnums.duelData.name);
    await localeManager.removeData(LocaleKeysEnums.gamePage.name);
  }

  String pickImageForGender(String gender) {
    if (gender == "Kadın") {
      return AssetConsts.instance.woman;
    } else {
      return AssetConsts.instance.man;
    }
  }
}
