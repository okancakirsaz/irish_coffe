import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/service/mock_services/profile_mock_services.dart';
import 'package:irish_coffe/core/widgets/are_you_sure_dialog.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/view/profile_view.dart';
import 'package:mobx/mobx.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_manager.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../../core/consts/color_consts/color_consts.dart';

part 'profile_viewmodel.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  String? userName;
  String? mail;
  String? profileImage;
  String? phoneNumber;
  final PageController pageController = PageController();
  final List<PostModel> posts = [];
  final ProfileMockServices services = ProfileMockServices();
  @observable
  bool? anonymValue;
  late final TextEditingController nameController;
  late final TextEditingController mailController;
  late final TextEditingController numberController;

  @override
  init() async {
    initProfileValues();
    nameController = TextEditingController(text: userName);
    mailController = TextEditingController(text: mail);
    numberController = TextEditingController(text: phoneNumber);
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

  showSureDialog(VoidCallback onPressed) {
    showDialog(
        context: viewModelContext,
        builder: (context) => AreYouSure(onPressed: onPressed));
  }

  initProfileValues() {
    userName = localeManager.getNullableStringData(LocaleKeysEnums.name.name);
    mail = localeManager.getNullableStringData(LocaleKeysEnums.mail.name);
    profileImage =
        localeManager.getNullableStringData(LocaleKeysEnums.profileImage.name);
    //TODO: Add this
    //phoneNumber =localeManager.getNullableStringData(LocaleKeysEnums.phoneNumber.name);
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

  openImageModeSelector() {
    showDialog(
        context: viewModelContext,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorConsts.instance.orange,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    color: ColorConsts.instance.lightGray,
                    size: 60,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.photo,
                    color: ColorConsts.instance.lightGray,
                    size: 60,
                  ),
                ),
              ],
            ),
          );
        });
  }

  //TODO: Add user token query
  Future<List<PostModel>> getUserPosts() async {
    final List<PostModel> response = await services.getUserPosts() ?? [];
    return response;
  }

  Future<List<ScoresModel>> getUserScores() async {
    final List<ScoresModel> response = await services.getUserScores() ?? [];
    return response;
  }

  Future<List<FavoreiteFoodsModel>> getUserFavoriteFoods() async {
    final List<FavoreiteFoodsModel> response =
        await services.getFavoriteFoods() ?? [];
    return response;
  }
}
