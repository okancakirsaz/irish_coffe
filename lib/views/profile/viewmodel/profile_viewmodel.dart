import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/view/profile_view.dart';
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
  @observable
  bool? anonymValue;
  late final TextEditingController nameController;
  late final TextEditingController mailController;

  @override
  init() async {
    initProfileValues();
    nameController = TextEditingController(text: userName);
    mailController = TextEditingController(text: mail);
    anonymValue =
        localeManager.getNullableBoolData(LocaleKeysEnums.isUserAnonym.name) ??
            false;
  }

  @action
  Future<void> changeAnonymValue(bool value) async {
    anonymValue = value;
    await localeManager.setBoolData(LocaleKeysEnums.isUserAnonym.name, value);
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

  navigateToSettings(ProfileViewModel viewModel) {
    Navigator.push(
        viewModelContext,
        CupertinoDialogRoute(
            builder: (context) => Settigns(
                  viewModel: viewModel,
                ),
            context: viewModelContext));
  }
}
