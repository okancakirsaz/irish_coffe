import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irish_coffe/core/service/mock_services/profile_mock_services.dart';
import 'package:irish_coffe/core/widgets/are_you_sure_dialog.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/models/user_settings_model.dart';
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
  String? password;
  String? token;
  UserDataModel? cameUserData;
  UserSettingsModel? settings;
  final PageController pageController = PageController();
  @observable
  ObservableList<PostModel> posts = ObservableList<PostModel>.of([]);
  final ProfileMockServices services = ProfileMockServices();
  @observable
  bool? anonymValue;
  late final TextEditingController nameController;
  late final TextEditingController mailController;
  late final TextEditingController numberController;
  late final TextEditingController passwordController;
  Uint8List? pickedImage;

  @override
  Future<bool> init() async {
    await initProfileValues();
    nameController = TextEditingController(text: userName);
    mailController = TextEditingController(text: mail);
    numberController = TextEditingController(text: phoneNumber);
    passwordController = TextEditingController(text: password);
    anonymValue =
        localeManager.getNullableBoolData(LocaleKeysEnums.isUserAnonym.name) ??
            settings?.isAnonym;
    //Returning any value because init function using in future builder and snapshot requires any data
    return true;
  }

  @action
  Future<void> changeAnonymValue(bool value) async {
    anonymValue = value;
  }

  Future<void> deleteAccount() async {
    final bool response = await services.deleteAccount(token!);
    if (response) {
      logOut();
    } else {
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz");
    }
  }

  changePageView(int index) {
    pageController.jumpToPage(index);
  }

  showSureDialog(VoidCallback onPressed) {
    showDialog(
        context: viewModelContext,
        builder: (context) => AreYouSure(onPressed: onPressed));
  }

  Future<void> _initSettings() async {
    settings = await services.getUserSettings();
  }

  Future<void> initProfileValues() async {
    if (cameUserData == null) {
      await _initSettings();
      userName =
          localeManager.getNullableStringData(LocaleKeysEnums.name.name) ??
              settings!.name;
      mail = localeManager.getNullableStringData(LocaleKeysEnums.mail.name) ??
          settings!.mail;
      profileImage = localeManager
              .getNullableStringData(LocaleKeysEnums.profileImage.name) ??
          settings?.photoUrl;
      phoneNumber = localeManager
              .getNullableStringData(LocaleKeysEnums.phoneNumber.name) ??
          settings!.phoneNumber;
      token = localeManager.getStringData(LocaleKeysEnums.token.name);
      password = settings?.password;
    } else {
      userName = cameUserData!.name;
      mail = cameUserData!.eMail;
      profileImage = cameUserData!.profileImage;
      token = cameUserData!.token;
    }
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
      await localeManager.removeData(LocaleKeysEnums.profileImage.name);
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
                  onPressed: () => _getNewProfileImage(ImageSource.camera),
                  icon: Icon(
                    Icons.camera_alt,
                    color: ColorConsts.instance.lightGray,
                    size: 60,
                  ),
                ),
                IconButton(
                  onPressed: () => _getNewProfileImage(ImageSource.gallery),
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

  Future<void> setNewUserSettings() async {
    final bool response = await services.setNewSettings(UserSettingsModel(
        name: nameController.text,
        mail: mailController.text,
        phoneNumber: numberController.text,
        isAnonym: anonymValue,
        password: passwordController.text
        //TODO: add profile image after real services
        ));
    if (response) {
      await _resetLocalSettingsValues();
      _navigatorPop();
    } else {
      Fluttertoast.showToast(msg: "Bir şeyler ters gitti, tekrar deneyiniz.");
    }
  }

  Future<void> _resetLocalSettingsValues() async {
    await _initSettings();
    await localeManager.setNullableStringData(
        LocaleKeysEnums.name.name, settings!.name);
    await localeManager.setNullableStringData(
        LocaleKeysEnums.phoneNumber.name, settings!.phoneNumber);
    await localeManager.setNullableStringData(
        LocaleKeysEnums.mail.name, settings!.mail);
    await localeManager.setBoolData(
        LocaleKeysEnums.isUserAnonym.name, settings!.isAnonym!);
    await localeManager.setNullableStringData(
        LocaleKeysEnums.profileImage.name, settings!.photoUrl);
  }

  _navigatorPop() {
    Navigator.pop(viewModelContext);
  }

  @action
  Future<List<PostModel>> getUserPosts() async {
    posts = ObservableList<PostModel>.of(
        await services.getUserPosts(cameUserData?.token ?? token!) ?? []);
    return posts;
  }

  Future<List<ScoresModel>> getUserScores() async {
    final List<ScoresModel> response =
        await services.getUserScores(cameUserData?.token ?? token!) ?? [];
    return response;
  }

  Future<List<FavoreiteFoodsModel>> getUserFavoriteFoods() async {
    final List<FavoreiteFoodsModel> response =
        await services.getFavoriteFoods(cameUserData?.token ?? token!) ?? [];
    return response;
  }

  Future<void> _getNewProfileImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    pickedImage = await image?.readAsBytes();
  }

  openPost(PostModel post, ProfileViewModel viewModel) {
    showDialog(
        context: viewModelContext,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            backgroundColor: ColorConsts.instance.green,
            content: OpenedPost(
              viewModel: viewModel,
              postData: post,
            ),
          );
        });
  }

  bool checkIsProfileMine(String comedToken) {
    if (localeManager.getNullableStringData(LocaleKeysEnums.token.name) ==
        comedToken) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteProfileImage() async {
    final bool response = await services.removeProfileImage(
        localeManager.getStringData(LocaleKeysEnums.token.name));
    if (!response) {
      Fluttertoast.showToast(msg: "Bir şeyler ters gitti. Tekrar deneyiniz.");
    } else {
      await localeManager.removeData(LocaleKeysEnums.profileImage.name);
      _navigatorPop();
    }
  }

  @action
  Future<void> deletePost(String postId) async {
    final bool response = await services.removePost(postId);
    if (response) {
      await getUserPosts();
    } else {
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz.");
    }
    _navigatorPop();
  }
}
