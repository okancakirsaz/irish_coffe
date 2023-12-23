import 'package:irish_coffe/views/community/models/post_model.dart';

class CommunityMockService {
  Future<List<PostModel>> getPosts() async {
    List<PostModel> modelList = [];
    for (var data in dataSet) {
      modelList.add(PostModel.fromJson(data));
    }
    return modelList;
  }

  Future<void> postNewPost(PostModel data) async {
    dataSet.add(data.toJson());
  }

  Future<String> getUserTokenFromPost(String postId) async {
    String token = "";
    for (var data in dataSet) {
      final PostModel dataAsModel = PostModel.fromJson(data);
      if (postId == dataAsModel.id) {
        token = dataAsModel.user!.token!;
      }
    }
    return token;
  }

  static List<Map<String, dynamic>> dataSet = [
    {
      "user": {
        "token": "UFC123JAOKF0P0ICdas",
        "name": "İrem Abdestsizyatmazoğulları",
        "profileImage": null,
        "gender": "Kadın"
      },
      "description": "Slayy",
      "apiImage":
          "https://i.pinimg.com/736x/e2/6f/c2/e26fc2050cd0ef606112ca18388a7264.jpg",
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
    {
      "user": {
        "token": "UFC123JAOKF0P0ICJOJFOĞ0Q0J03UJVPOAS",
        "name": "Volkan Konak",
        "profileImage":
            "https://i.pinimg.com/236x/0f/74/81/0f7481fcf1051babffa8a03c34c24ea8.jpg",
        "gender": "Erkek"
      },
      "description": "Merhaba ben Volkan Konak",
      "apiImage":
          "https://i.pinimg.com/236x/e9/f8/60/e9f860c5f3c43baf6eaf408cb58a63c0.jpg",
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdsadas"
    },
  ];
}
