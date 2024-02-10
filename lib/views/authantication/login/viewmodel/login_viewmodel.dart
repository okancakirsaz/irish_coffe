import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/views/authantication/login/models/login_request_model.dart';
import 'package:irish_coffe/views/authantication/login/services/login_services.dart';
import 'package:mobx/mobx.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_manager.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {}
  final LoginServices services = LoginServices();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> tryToLogin({String? cameMail, String? camePassword}) async {
    try {
      final UserDataModel? response = await services.sendLoginRequest(
          LoginRequestModel(
              mail: cameMail ?? emailController.text,
              password: camePassword ?? passwordController.text));

      if (response != null && !response.isUserBanned!) {
        //Navigate to main page
        await _cacheDatas(response);
        navigateToMainPage();
      } else {
        _checkFailReason(response!);
      }
    } catch (_) {
      //TODO: Add craslytics
      showErrorDialog("Beklenmeyen bir sorun oluştu. Lütfen tekrar deneyiniz.");
    }
  }

  _checkFailReason(UserDataModel response) {
    if (response.isUserBanned!) {
      showErrorDialog(
          "Topluluk kurallarımıza uygun davranışlarda bulunmadığınız için uygulamadan süresiz olarak uzaklaştırıldınız.");
    } else {
      showErrorDialog("Email veya şifre yanlış, tekrar deneyiniz.");
    }
  }

  Future<void> _cacheDatas(UserDataModel response) async {
    try {
      await localeManager.setNullableStringData(
          LocaleKeysEnums.token.name, response.token);
      await localeManager.setNullableStringData(
          LocaleKeysEnums.name.name, response.name);
      await localeManager.setStringData(
          LocaleKeysEnums.mail.name, response.email!);
      await localeManager.setStringData(
          LocaleKeysEnums.phoneNumber.name, response.phoneNumber!);
      await localeManager.setNullableStringData(
          LocaleKeysEnums.profileImage.name, response.profileImage);
      await localeManager.setStringData(
          LocaleKeysEnums.userId.name, response.uid!);
      await localeManager.setNullableStringData(
          LocaleKeysEnums.gender.name, response.gender);
    } catch (e) {
      //TODO: Add crashlytics
      showErrorDialog("Bir şeyler ters gitti, lütfen tekrar deneyiniz.");
    }
  }

  showErrorDialog(String reason) {
    Fluttertoast.showToast(msg: reason);
  }

  navigateToMainPage() {
    NavigationManager.instance
        .removeUntil(NavigationEnums.MAIN, viewModelContext);
  }
}
