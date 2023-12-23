// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';

final class CommunityServices extends NetworkManager {
  Future<List<PostModel>?> getPosts() async {
    try {
      final response = await network.get("/community-shares");
      List<PostModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(PostModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<PostModel?> postNewPost(PostModel data) async {
    try {
      final response = await network.post("/share-post", data: data);
      return PostModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
