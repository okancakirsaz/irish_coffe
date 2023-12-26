// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/user_token_send_request_model.dart';
import 'package:irish_coffe/views/profile/models/boolean_single_response_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/post_id_send_request_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/models/user_settings_model.dart';

final class ProfileServices extends NetworkManager {
  Future<List<PostModel>?> getUserPosts(String userToken) async {
    try {
      final response = await network.get(AppConst.instance.users,
          queryParameters: {"tokenForPosts": userToken});
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

  Future<List<ScoresModel>?> getUserScores(String userToken) async {
    try {
      final response = await network.get(AppConst.instance.users,
          queryParameters: {"tokenForScores": userToken});
      List<ScoresModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(ScoresModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<List<FavoreiteFoodsModel>?> getFavoriteFoods(String userToken) async {
    try {
      final response = await network.get(AppConst.instance.users,
          queryParameters: {"tokenForFoods": userToken});
      List<FavoreiteFoodsModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(FavoreiteFoodsModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BooleanSingleResponseModel?> deleteAccount(
      UserTokenSendRequestModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.deleteAccount, data: data);
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<UserSettingsModel?> getUserSettings(String userToken) async {
    try {
      final response = await network.get(AppConst.instance.userSettings,
          queryParameters: {"token": userToken});
      return UserSettingsModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<UserSettingsModel?> setNewSettings(UserSettingsModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.setNewUserSettings, data: data);
      return UserSettingsModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BooleanSingleResponseModel?> removePost(
      PostIdSendRequestModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.deletePost, data: data);
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BooleanSingleResponseModel?> removeProfileImage(
      UserTokenSendRequestModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.deleteProfileImage, data: data);
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
