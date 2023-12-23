import 'package:irish_coffe/views/authantication/forgot_password/model/forgot_password_response_model.dart';

class ForgotPasswordMockService {
  ForgotPasswordResponseModel? getStatus(String mail) {
    try {
      return ForgotPasswordResponseModel.fromJson(alternativeDataSet);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> dataSet = {
    "mailAdress": "ocakirsaz@gmail.com",
    "isMailSended": true,
    "reason": null
  };

  Map<String, dynamic> alternativeDataSet = {
    "mailAdress": "ocakirsaz@g",
    "isMailSended": false,
    "reason": "This mail adress is not valid"
  };
}
