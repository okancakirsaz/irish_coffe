import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/menu/models/menu_item_model.dart';

final class MenuServices extends NetworkManager {
  Future<List<MenuItemModel>?> getAllMenu() async {
    try {
      final response = await network.get("/get-menu");
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
}
