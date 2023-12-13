import 'dart:typed_data';

import 'package:irish_coffe/views/community/models/post_model.dart';

import '../../../views/authantication/core/models/user_data_model.dart';

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
        token = dataAsModel.user!.token;
      }
    }
    return token;
  }

  static List<Map<String, dynamic>> dataSet = [
    {
      "user": UserDataModel.fromJson({
        "token": "UFC123JAOKF0P0ICdas",
        "name": "İrem Abdestsizyatmazoğulları",
        "profileImage": ""
      }),
      "description": "Slayy",
      "apiImage":
          "https://i.pinimg.com/736x/e2/6f/c2/e26fc2050cd0ef606112ca18388a7264.jpg",
      "image": Uint8List(3),
      "time": "15.12.2023 14:53",
      "id": "sdsds-dasdsa-dasdsa-dasdas"
    },
  ];
}
