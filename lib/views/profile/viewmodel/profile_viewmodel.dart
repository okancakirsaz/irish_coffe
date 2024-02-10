import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irish_coffe/core/init/model/lite_user_data_model.dart';
import 'package:irish_coffe/core/public_managers/log_out_manager.dart';
import 'package:irish_coffe/core/widgets/are_you_sure_dialog.dart';
import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_request_model.dart';
import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_response_model.dart';
import 'package:irish_coffe/views/authantication/forgot_password/service/forgot_password_services.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/boolean_single_response_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/post_id_send_request_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/models/update_profile_image_model.dart';
import 'package:irish_coffe/views/profile/models/user_settings_model.dart';
import 'package:irish_coffe/views/profile/models/user_id_send_request_model.dart';
import 'package:irish_coffe/views/profile/services/profile_services.dart';
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

  @observable
  String? userName;
  String? mail;
  @observable
  String? profileImage;
  String? phoneNumber;
  String? token;
  String? gender;
  String? uid;
  LiteUserDataModel? cameUserData;
  UserSettingsModel? settings;
  final PageController pageController = PageController();
  @observable
  ObservableList<PostModel> posts = ObservableList<PostModel>.of([]);
  final ProfileServices services = ProfileServices();
  @observable
  bool? anonymValue;
  late final TextEditingController nameController;
  late final TextEditingController mailController;
  late final TextEditingController numberController;
  Uint8List? pickedImage;

  LogOutManager get logOutManager => LogOutManager(viewModelContext);

  @override
  Future<bool> init() async {
    await initProfileValues();
    nameController = TextEditingController(text: userName);
    mailController = TextEditingController(text: mail);
    numberController = TextEditingController(text: phoneNumber);
    //Returning any value because init function using in future builder and snapshot requires any data
    return true;
  }

  @action
  Future<void> changeAnonymValue(bool value) async {
    anonymValue = value;
  }

  Future<void> deleteAccount() async {
    final BooleanSingleResponseModel? response =
        await services.deleteAccount(UserIdSendRequestModel(uid: uid!));
    if (response != null) {
      if (response.isSuccess!) {
        await logOutManager.logOut();
      } else {
        Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz");
      }
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
    settings = await services.getUserSettings(
        localeManager.getStringData(LocaleKeysEnums.token.name));
  }

  Future<void> initProfileValues() async {
    if (cameUserData == null) {
      await _initSettings();
      userName =
          localeManager.getNullableStringData(LocaleKeysEnums.name.name) ??
              settings!.name;
      mail = localeManager.getNullableStringData(LocaleKeysEnums.mail.name) ??
          settings!.email;
      profileImage = localeManager
              .getNullableStringData(LocaleKeysEnums.profileImage.name) ??
          settings?.photoUrl;
      phoneNumber = localeManager
              .getNullableStringData(LocaleKeysEnums.phoneNumber.name) ??
          settings!.phoneNumber;
      token = localeManager.getStringData(LocaleKeysEnums.token.name);
      anonymValue = localeManager
              .getNullableBoolData(LocaleKeysEnums.isUserAnonym.name) ??
          settings?.isAnonym;
      uid = localeManager.getStringData(LocaleKeysEnums.userId.name);
      gender = localeManager.getStringData(LocaleKeysEnums.gender.name);
    } else {
      gender = cameUserData!.gender;
      userName = cameUserData!.name;
      profileImage = cameUserData!.profileImage;
      token = cameUserData!.token;
    }
  }

  navigateToResetPassword() {
    NavigationManager.instance
        .navigateTo(NavigationEnums.FORGOT_PASSWORD, viewModelContext);
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

  Future<void> sendResetPasswordEmail() async {
    //Dependency Injection!
    final ForgotPasswordResponseModel? response = await ForgotPasswordServices()
        .postEmailData(ForgotPasswordRequestModel(email: mail!));
    if (response != null) {
      if (response.isMailSended) {
        Fluttertoast.showToast(msg: "Sıfırlama e-postası gönderildi.");
        navigateToLoginPage();
      } else {
        Fluttertoast.showToast(msg: response.reason!);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Beklenmeyen bir sorun oluştu, tekrar deneyiniz.");
    }
  }

  navigateToLoginPage() {
    NavigationManager.instance
        .removeUntil(NavigationEnums.LOGIN, viewModelContext);
  }

  @action
  Future<void> setNewUserSettings() async {
    final UserSettingsModel? response = await services.setNewSettings(
        UserSettingsModel(
            name: nameController.text,
            email: mailController.text,
            phoneNumber: numberController.text,
            isAnonym: anonymValue,
            photoUrl: profileImage),
        token!);
    if (response != null) {
      await _resetLocalSettingsValues();
      _navigatorPop();
    } else {
      Fluttertoast.showToast(msg: "Bir şeyler ters gitti, tekrar deneyiniz.");
    }
  }

  Future<void> _resetLocalSettingsValues() async {
    await _initSettings();
    /*This function is not saving your changes to local. This function saving api settings datas to local */
    await localeManager.setNullableStringData(
        LocaleKeysEnums.name.name, settings!.name);
    await localeManager.setNullableStringData(
        LocaleKeysEnums.phoneNumber.name, settings!.phoneNumber);
    await localeManager.setNullableStringData(
        LocaleKeysEnums.mail.name, settings!.email);
    await localeManager.setBoolData(
        LocaleKeysEnums.isUserAnonym.name, settings!.isAnonym!);
    await localeManager.setNullableStringData(
        LocaleKeysEnums.profileImage.name, settings!.photoUrl);
  }

  _navigatorPop() {
    if (Navigator.of(viewModelContext).canPop()) {
      Navigator.pop(viewModelContext);
    } else {
      //Nothing
    }
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
    final XFile? image =
        await picker.pickImage(source: source, imageQuality: 20);
    pickedImage = await image?.readAsBytes();
    await _setNewProfileImage();
  }

  @action
  Future<void> _setNewProfileImage() async {
    final UpdateProfileImageModel? response = await services.updateProfileImage(
      UpdateProfileImageModel(
        uid: uid,
        imageAsByte: base64Encode(pickedImage!),
      ),
    );
    await localeManager.setNullableStringData(
        LocaleKeysEnums.profileImage.name, response!.profileImage);
    profileImage = response.profileImage;
    _navigatorPop();
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

  @action
  Future<void> deleteProfileImage() async {
    final BooleanSingleResponseModel? response =
        await services.removeProfileImage(
      UserIdSendRequestModel(
        uid: localeManager.getStringData(LocaleKeysEnums.userId.name),
      ),
    );
    if (response != null) {
      if (response.isSuccess == false) {
        Fluttertoast.showToast(msg: "Bir şeyler ters gitti. Tekrar deneyiniz.");
      } else {
        await localeManager.removeData(LocaleKeysEnums.profileImage.name);
        profileImage = null;
        _navigatorPop();
      }
    }
  }

  @action
  Future<void> deletePost(String postId) async {
    final BooleanSingleResponseModel? response = await services
        .removePost(PostIdSendRequestModel(postId: postId, token: token));
    if (response != null && response.isSuccess!) {
      await getUserPosts();
    } else {
      Fluttertoast.showToast(msg: "Bir sorun oluştu, tekrar deneyiniz.");
    }
    _navigatorPop();
  }
}
