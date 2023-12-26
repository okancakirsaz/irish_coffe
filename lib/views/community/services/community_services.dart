// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/community/models/currently_in_irish_model.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';

final class CommunityServices extends NetworkManager {
  Future<List<PostModel>?> getPosts() async {
    try {
      final response = await network.get(AppConst.instance.communityShares);
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
      final response =
          await network.post(AppConst.instance.sharePost, data: data);
      return PostModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<List<CurrentlyInIrishModel>?> getWhoInIrishData() async {
    try {
      final response = await network.get(AppConst.instance.currentlyInIrish);
      List<CurrentlyInIrishModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(CurrentlyInIrishModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
