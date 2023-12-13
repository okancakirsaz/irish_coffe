import 'dart:typed_data';

import 'package:irish_coffe/core/service/mock_services/login_mock_services.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/models/user_settings_model.dart';

class ProfileMockServices {
  Future<List<PostModel>?> getUserPosts() async {
    List<PostModel> response = [];
    for (Map<String, dynamic> post in posts) {
      response.add(PostModel.fromJson(post));
    }
    return response;
  }

  Future<List<ScoresModel>?> getUserScores() async {
    List<ScoresModel> response = [];
    for (Map<String, dynamic> score in scores) {
      response.add(ScoresModel.fromJson(score));
    }
    return response;
  }

  Future<List<FavoreiteFoodsModel>?> getFavoriteFoods() async {
    List<FavoreiteFoodsModel> response = [];
    for (Map<String, dynamic> food in foods) {
      response.add(FavoreiteFoodsModel.fromJson(food));
    }
    return response;
  }

  Future<bool> deleteAccount(String userToken) async {
    try {
      Map<String, dynamic>? deletableUser;
      for (Map<String, dynamic> user in LoginMockServices.dataSet) {
        if (user["token"] == userToken) {
          deletableUser = user;
        }
      }
      LoginMockServices.dataSet.remove(deletableUser);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserSettingsModel> getUserSettings() async {
    return UserSettingsModel.fromJson(userSettings);
  }

  Future<bool> setNewSettings(UserSettingsModel newSettings) async {
    try {
      userSettings = newSettings.toJson();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Map<String, dynamic>> foods = [
    {
      "foodName": "Irish Coffee",
      "count": 10,
      "photo":
          "https://i.pinimg.com/236x/d4/6c/54/d46c545effbcadc65546b9a6d3ba8697.jpg",
    }
  ];

  List<Map<String, dynamic>> scores = [
    {
      "userName": "İsmet Okan Çakırsaz",
      "challengedUserName": "Volkan Konak",
      "isWinned": true,
      "game": "Yılan ve Yonca"
    },
    {
      "userName": "İsmet Okan Çakırsaz",
      "challengedUserName": "Ahmet Kaya",
      "isWinned": false,
      "game": "Bil ve Kazan"
    },
    {
      "userName": "İsmet Okan Çakırsaz",
      "challengedUserName": "Süleyman Soyluluğutartışılıroğulları",
      "isWinned": true,
      "game": "Yılan ve Yonca"
    },
    {
      "userName": "İsmet Okan Çakırsaz",
      "challengedUserName": "Yan Caman",
      "isWinned": true,
      "game": "Yılan ve Yonca"
    },
  ];

  List<Map<String, dynamic>> emptyPosts = [];

  List<Map<String, dynamic>> posts = [
    {
      "user": UserDataModel.fromJson({
        "token": "aodjspodja",
        "name": "İsmet Okan Çakırsaz",
        "profileImage": null
      }),
      "description": "Merhaba ben Volkan Konak",
      "apiImage":
          "https://i.pinimg.com/736x/e2/6f/c2/e26fc2050cd0ef606112ca18388a7264.jpg",
      "image": Uint8List(3),
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
    {
      "user": UserDataModel.fromJson({
        "token": "aodjspodja",
        "name": "İsmet Okan Çakırsaz",
        "profileImage": null
      }),
      "description": "Merhaba ben Volkan Konak",
      "apiImage":
          "https://i.pinimg.com/564x/a9/16/8f/a9168f747a41c1bc579db2bc0d6462db.jpg",
      "image": Uint8List(3),
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
    {
      "user": UserDataModel.fromJson({
        "token": "aodjspodja",
        "name": "İsmet Okan Çakırsaz",
        "profileImage": null
      }),
      "description": "Merhaba ben Volkan Konak",
      "apiImage":
          "https://i.pinimg.com/236x/e9/f8/60/e9f860c5f3c43baf6eaf408cb58a63c0.jpg",
      "image": Uint8List(3),
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
    {
      "user": UserDataModel.fromJson({
        "token": "aodjspodja",
        "name": "İsmet Okan Çakırsaz",
        "profileImage": null
      }),
      "description": "Merhaba ben Volkan Konak",
      "apiImage":
          "https://i.pinimg.com/236x/f8/53/77/f853778f768c27f9b3a4ad78c885d47e.jpg",
      "image": Uint8List(3),
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
  ];

  Map<String, dynamic> userSettings = {
    "photoUrl": null,
    "name": "Yan Caman",
    "mail": "user@gmail.com",
    "phoneNumber": "05321343200",
    "isAnonym": true,
  };
}
