import 'dart:typed_data';

import 'package:irish_coffe/views/authantication/core/models/user_data_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';

class ProfileMockServices {
  Future<List<PostModel>?> getUserPosts() async {
    List<PostModel> response = [];
    for (Map<String, dynamic> post in posts) {
      response.add(PostModel.fromJson(post));
    }
    return response;
  }

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
}
