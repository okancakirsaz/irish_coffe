import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_request_model.dart';
import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_response_model.dart';
import 'package:irish_coffe/views/authantication/forgot_password/service/forgot_password_services.dart';
import 'package:mobx/mobx.dart';
import 'package:irish_coffe/core/init/cache/local_keys_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_enums.dart';
import 'package:irish_coffe/core/init/navigation/navigation_manager.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';

part 'forgot_password_viewmodel.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store, BaseViewModel {
  //If status from service is true go back login screen
  //If status from service is false show reason screen

  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    String? cachedMailData =
        localeManager.getNullableStringData(LocaleKeysEnums.mail.name);
    if (cachedMailData != null) {
      controller.text = cachedMailData;
    }
  }

  final ForgotPasswordServices service = ForgotPasswordServices();
  final TextEditingController controller = TextEditingController();

  Future<void> takeMailStatus() async {
    final ForgotPasswordResponseModel? response = await service
        .postEmailData(ForgotPasswordRequestModel(email: controller.text));
    if (response != null) {
      if (response.isMailSended) {
        Fluttertoast.showToast(msg: "Doğrulama e-postası gönderildi.");
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
}
