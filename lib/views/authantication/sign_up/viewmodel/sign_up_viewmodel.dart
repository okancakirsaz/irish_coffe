// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/authantication/sign_up/services/sign_up_services.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import '../../login/viewmodel/login_viewmodel.dart';

part 'sign_up_viewmodel.g.dart';

class SignUpViewModel = _SignUpViewModelBase with _$SignUpViewModel;

abstract class _SignUpViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  void init() {
    loginViewModel.viewModelContext = viewModelContext;
  }

  final SignUpServices services = SignUpServices();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final LoginViewModel loginViewModel = LoginViewModel();

  showErrorDialog(String reason) {
    Fluttertoast.showToast(msg: reason);
  }

  Future<void> createMembership() async {
    try {
      final UserDataModel request = UserDataModel(
        token: null,
        profileImage: null,
        name: nameController.text,
        gender: genderController.text,
        phoneNumber: numberController.text,
        password: passwordController.text,
        uid: null,
        posts: [],
        favoriteFoods: [],
        scores: [],
        email: emailController.text,
      );

      if (_validation(request)) {
        await services.sendSignUpRequest(request);
        await loginViewModel.tryToLogin(
            cameMail: emailController.text,
            camePassword: passwordController.text);
      }
    } catch (e) {
      showErrorDialog("Bir şeyler ters gitti. Lütfen tekrar deneyiniz");
    }
  }

  bool _validation(UserDataModel response) {
    if (validateName(response.name!) &&
        validateMail(response.email!) &&
        validatePassword(response.password!) &&
        validatePhoneNumber(response.phoneNumber!) &&
        response.gender != "") {
      return true;
    } else {
      return false;
    }
  }

  bool validateName(String name) {
    if (name.length <= 30 && name.length >= 8) {
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "İsim 8 karakterden küçük 30 karakterden büyük olamaz.");
      return false;
    }
  }

  bool validatePhoneNumber(String number) {
    if (number.length == 11) {
      return true;
    } else {
      Fluttertoast.showToast(msg: "Lütfen geçerli bir numara giriniz.");
      return false;
    }
  }

  bool validatePassword(String password) {
    if (password.length >= 8) {
      return true;
    } else {
      Fluttertoast.showToast(msg: "Şifre 8 karakterden küçük olamaz.");
      return false;
    }
  }

  bool validateMail(String mail) {
    if (mail.contains("@")) {
      return true;
    } else {
      Fluttertoast.showToast(msg: "Lütfen geçerli bir mail adresi giriniz.");
      return false;
    }
  }
}
