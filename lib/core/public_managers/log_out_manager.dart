import 'package:flutter/src/widgets/framework.dart';
import 'package:irish_coffe/core/base/viewmodel/base_viewmodel.dart';

import '../init/cache/local_keys_enums.dart';
import '../init/navigation/navigation_enums.dart';
import '../init/navigation/navigation_manager.dart';

final class LogOutManager extends BaseViewModel {
  LogOutManager(BuildContext viewModelContext);

  @override
  void setContext(BuildContext context) {}

  Future<void> logOut() async {
    await _clearCache();
    _navigateToLoginPage();
  }

  Future<void> _clearCache() async {
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

  _navigateToLoginPage() {
    NavigationManager.instance
        .removeUntil(NavigationEnums.LOGIN, viewModelContext);
  }
}
