// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/community/models/post_model.dart';
import 'package:irish_coffe/views/profile/models/update_profile_image_model.dart';
import 'package:irish_coffe/views/profile/models/user_id_send_request_model.dart';
import 'package:irish_coffe/views/profile/models/boolean_single_response_model.dart';
import 'package:irish_coffe/views/profile/models/favorite_foods_model.dart';
import 'package:irish_coffe/views/profile/models/post_id_send_request_model.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';
import 'package:irish_coffe/views/profile/models/user_settings_model.dart';

final class ProfileServices extends NetworkManager {
  Future<List<PostModel>?> getUserPosts(String userToken) async {
    try {
      final response = await network.get(AppConst.instance.userPosts,
          options: Options(headers: {"token": userToken}));
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
      final response = await network.get(AppConst.instance.userScores,
          options: Options(headers: {"token": userToken}));
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
      final response = await network.get(AppConst.instance.userFoods,
          options: Options(headers: {"token": userToken}));
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
      UserIdSendRequestModel data) async {
    try {
      final response = await network.post(AppConst.instance.deleteAccount,
          data: data.toJson());
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<UserSettingsModel?> getUserSettings(String userToken) async {
    try {
      final response = await network.get(AppConst.instance.userSettings,
          options: Options(headers: {"token": userToken}));
      return UserSettingsModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<UserSettingsModel?> setNewSettings(
      UserSettingsModel data, String userToken) async {
    try {
      final response = await network.post(AppConst.instance.setNewUserSettings,
          data: data.toJson(), options: Options(headers: {"token": userToken}));
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
          await network.post(AppConst.instance.deletePost, data: data.toJson());
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BooleanSingleResponseModel?> removeProfileImage(
      UserIdSendRequestModel data) async {
    try {
      final response = await network.post(AppConst.instance.deleteProfileImage,
          data: data.toJson());
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<UpdateProfileImageModel?> updateProfileImage(
      UpdateProfileImageModel data) async {
    try {
      final response = await network.post(AppConst.instance.updateProfileImage,
          data: data.toJson());
      return UpdateProfileImageModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
