import 'package:flutter/material.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:mobx/mobx.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_manager.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'profile_viewmodel.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  String? userName;
  String? mail;
  String? profileImage;
  final PageController pageController = PageController();
  final List<PostModel> posts = [];
  @override
  init() async {
    initProfileValues();
  }

  changePageView(int index) {
    pageController.jumpToPage(index);
  }

  initProfileValues() {
    userName = localeManager.getNullableStringData(LocaleKeysEnums.name.name);
    mail = localeManager.getNullableStringData(LocaleKeysEnums.mail.name);
    profileImage =
        localeManager.getNullableStringData(LocaleKeysEnums.profileImage.name);
  }

  navigateToResetPassword() {
    NavigationManager.instance
        .navigateTo(NavigationEnums.FORGOT_PASSWORD, viewModelContext);
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
    } catch (e) {
      //TODO: Add crashlytics
    }
  }

  navigateToLoginPage() {
    NavigationManager.instance
        .removeUntil(NavigationEnums.LOGIN, viewModelContext);
  }
}
