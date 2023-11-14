import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_manager.dart';
import 'package:irish_coffe/core/service/mock_services/login_mock_services.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {}
  final LoginMockServices services = LoginMockServices();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> tryToLogin({String? comedMail, String? comedPassword}) async {
    try {
      final UserDataModel? response = services.getUserData(
          comedMail ?? emailController.text,
          comedPassword ?? passwordController.text);

      if (response != null) {
        //Navigate to main page
        await cacheDatas(response);
        navigateToMainPage();
      } else {
        showErrorDialog("Email veya şifre yanlış, tekrar deneyiniz.");
      }
    } catch (_) {
      //TODO: Add craslytics
      showErrorDialog("Email veya şifre yanlış, tekrar deneyiniz.");
    }
  }

  Future<void> cacheDatas(UserDataModel response) async {
    try {
      await localeManager.setStringData(
          LocaleKeysEnums.token.name, response.token);
      await localeManager.setStringData(
          LocaleKeysEnums.name.name, response.name);
      await localeManager.setStringData(
          LocaleKeysEnums.mail.name, response.eMail!);
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
