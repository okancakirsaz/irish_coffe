import 'package:irish_coffe/core/service/mock_services/login_mock_services.dart';
import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/models/user_settings_model.dart';

class ProfileMockServices {
  Future<List<PostModel>?> getUserPosts(String userToken) async {
    List<PostModel> response = [];
    for (Map<String, dynamic> data in dataSet) {
      if (data["token"] == userToken) {
        for (Map<String, dynamic> post in data["posts"]) {
          try {
            post["user"] = UserDataModel.fromJson(post["user"]);
          } catch (e) {
            //Already converted
          }
          final PostModel postAsModel = PostModel.fromJson(post);
          response.add(postAsModel);
        }
      }
    }
    return response;
  }

  Future<List<ScoresModel>?> getUserScores(String userToken) async {
    List<ScoresModel> response = [];
    for (Map<String, dynamic> data in dataSet) {
      if (data["token"] == userToken) {
        for (Map<String, dynamic> score in data["scores"]) {
          response.add(ScoresModel.fromJson(score));
        }
      }
    }
    return response;
  }

  Future<List<FavoreiteFoodsModel>?> getFavoriteFoods(String userToken) async {
    List<FavoreiteFoodsModel> response = [];
    for (Map<String, dynamic> data in dataSet) {
      if (data["token"] == userToken) {
        for (Map<String, dynamic> food in data["favoriteFoods"]) {
          response.add(FavoreiteFoodsModel.fromJson(food));
        }
      }
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

  Future<bool> removePost(String postId) async {
    try {
      Map<String, dynamic>? removablePost;
      for (Map<String, dynamic> data in dataSet) {
        for (Map<String, dynamic> post in data["posts"]) {
          if (post["id"] == postId) {
            removablePost = post;
          }
        }
        data["posts"].remove(removablePost);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeProfileImage(String userToken) async {
    try {
      for (Map<String, dynamic> data in dataSet) {
        if (data["token"] == userToken) {
          data["profileImage"] = null;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> userSettings = {
    "photoUrl": null,
    "mail": "ocakirsaz@gmail.com",
    "name": "Volkan Konak",
    "phoneNumber": "05321343200",
    "isAnonym": false,
    "password": "deneme123"
  };

  static List<Map<String, dynamic>> dataSet = [
    {
      "e_mail": "ocakirsaz@gmail.com",
      "password": "deneme123",
      "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
      "name": "Volkan Konak",
      "gender": "Erkek",
      "profileImage":
          "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg",
      "phoneNumber": "0532 134 32 00",
      "posts": [
        {
          "user": {
            "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
            "name": "Volkan Konak",
            "profileImage":
                "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg"
          },
          "description": "Merhaba ben Volkan Konak",
          "apiImage":
              "https://i.pinimg.com/236x/e9/f8/60/e9f860c5f3c43baf6eaf408cb58a63c0.jpg",
          "time": "15.12.2023 14:53",
          "id": "sdsds-dasdasdsa-dasdsa-dasdas"
        },
        {
          "user": {
            "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
            "name": "Volkan Konak",
            "profileImage":
                "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg"
          },
          "description": "Merhaba ben Volkan Konak",
          "apiImage":
              "https://i.pinimg.com/236x/9c/78/e0/9c78e019e1847ba9dc29c1bd6b75eeab.jpg",
          "time": "15.12.2023 14:53",
          "id": "sdsds-dadasdsa-dasdsa-dasdas"
        },
        {
          "user": {
            "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
            "name": "Volkan Konak",
            "profileImage":
                "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg"
          },
          "description": "Merhaba ben Volkan Konak",
          "apiImage":
              "https://i.pinimg.com/236x/bf/86/c9/bf86c98fad4a1b3b20eb0644780e62ec.jpg",
          "time": "15.12.2023 14:53",
          "id": "sdsds-daassdsa-dasdsa-dasdas"
        }
      ],
      "scores": [
        {
          "userName": "Volkan Konak",
          "challengedUserName": "Süleyman Soyluluğutartışılıroğulları",
          "isWinned": true,
          "game": "Yılan ve Yonca"
        },
        {
          "userName": "Volkan Konak",
          "challengedUserName": "Yan Caman",
          "isWinned": true,
          "game": "Yılan ve Yonca"
        },
        {
          "userName": "Volkan Konak",
          "challengedUserName": "Vahdettin Beyaz",
          "isWinned": true,
          "game": "Yılan ve Yonca"
        }
      ],
      "favoriteFoods": [
        {
          "foodName": "Irish Coffee",
          "count": 10,
          "photo":
              "https://i.pinimg.com/236x/d4/6c/54/d46c545effbcadc65546b9a6d3ba8697.jpg"
        }
      ]
    },
    {
      "e_mail": "explode03@gmail.com",
      "password": "slay",
      "token": "UFC123JAOKF0P0ICdas",
      "name": "İrem Abdestsizyatmazoğulları",
      "gender": "Kadın",
      "profileImage": null,
      "phoneNumber": "05321343200",
      "posts": [
        {
          "user": {
            "token": "UFC123JAOKF0P0ICdas",
            "name": "İrem Abdestsizyatmazoğulları",
            "profileImage": null
          },
          "description": "Slayyy",
          "apiImage":
              "https://i.pinimg.com/236x/84/7f/e9/847fe98af13d049a78bf28738ea6e166.jpg",
          "time": "15.12.2023 14:53",
          "id": "sdsds-dadsdsa-dasdsa-dasdas"
        },
        {
          "user": {
            "token": "UFC123JAOKF0P0ICdas",
            "name": "İrem Abdestsizyatmazoğulları",
            "profileImage": null
          },
          "description": "Slayyy",
          "apiImage":
              "https://i.pinimg.com/236x/67/0e/85/670e854e190f68acb7041d8c18cb3722.jpg",
          "time": "15.12.2023 14:53",
          "id": "sdsds-dasdfsa-dasdsa-dasdas"
        },
      ],
      "scores": [
        {
          "userName": "İrem Abdestsizyatmazoğulları",
          "challengedUserName": "Süleyman Soyluluğutartışılıroğulları",
          "isWinned": false,
          "game": "Yılan ve Yonca"
        },
        {
          "userName": "İrem Abdestsizyatmazoğulları",
          "challengedUserName": "Yan Caman",
          "isWinned": false,
          "game": "Yılan ve Yonca"
        },
        {
          "userName": "İrem Abdestsizyatmazoğulları",
          "challengedUserName": "Vahdettin Beyaz",
          "isWinned": false,
          "game": "Yılan ve Yonca"
        }
      ],
      "favoriteFoods": [
        {
          "foodName": "Irish Püre",
          "count": 12,
          "photo":
              "https://i.pinimg.com/236x/d4/6c/54/d46c545effbcadc65546b9a6d3ba8697.jpg"
        }
      ]
    }
  ];
}
