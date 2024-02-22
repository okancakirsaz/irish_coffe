import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/menu/models/bucket_verification_request_model.dart';
import 'package:irish_coffe/views/menu/models/bucket_verification_response_model.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';

final class MenuServices extends NetworkManager {
  Future<List<MenuItemModel>?> getAllMenu() async {
    try {
      final response = await network.get(AppConst.instance.getMenu);
      List<MenuItemModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(MenuItemModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<MenuItemModel?> getMenuItem(String itemName) async {
    try {
      final response = await network
          .post(AppConst.instance.getMenuItem, data: {"itemName": itemName});
      return MenuItemModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BucketVerificationResponseModel?> bucketVerification(
      BucketVerificationRequestModel data) async {
    try {
      final response = await network.post(AppConst.instance.bucketVerification,
          data: data.toJson());
      return BucketVerificationResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
