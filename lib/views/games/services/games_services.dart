import 'package:flutter/material.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/games/models/event_model.dart';

final class GamesServices extends NetworkManager {
  Future<List<EventModel>?> getActiveEvents() async {
    try {
      final response = await network.get(AppConst.instance.getActiveEvents);
      List<EventModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(EventModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
