import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';

class LoginMockServices {
  UserDataModel? getUserData(String mail, String password) {
    Map<String, dynamic>? calledUser;
    try {
      for (int i = 0; i <= dataSet.length - 1; i++) {
        if (mail == dataSet[i]["e_mail"] &&
            password == dataSet[i]["password"]) {
          calledUser = dataSet[i];
        }
      }
      return UserDataModel.fromJson(calledUser!);
    } catch (_) {
      return null;
    }
  }

  static Future<UserDataModel> findUserFromToken(String token) async {
    UserDataModel res = UserDataModel(
        token: "", profileImage: "", name: "name", phoneNumber: "phoneNumber");
    for (var data in dataSet) {
      final UserDataModel dataAsModel = UserDataModel.fromJson(data);
      if (dataAsModel.token == token) {
        res = dataAsModel;
      }
    }
    return res;
  }

  static List<Map<String, dynamic>> dataSet = [
    {
      "e_mail": "ocakirsaz@gmail.com",
      "password": "deneme123",
      "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
      "name": "Volkan Konak",
      "gender": "Erkek",
      "profileImage":
          "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg",
      "phoneNumber": "0532 134 32 00"
    },
    {
      "e_mail": "ocakirsaz@hotmail.com",
      "password": "deneme123",
      "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
      "name": "Okan Reis",
      "gender": "Erkek",
      "profileImage": null,
      "phoneNumber": "0532 134 32 11"
    },
    {
      "e_mail": "explode03@gmail.com",
      "password": "slay",
      "token": "UFC123JAOKF0P0ICdas",
      "name": "İrem Abdestsizyatmazoğulları",
      "gender": "Kadın",
      "profileImage": null,
      "phoneNumber": "0532123232"
    },
  ];
}
