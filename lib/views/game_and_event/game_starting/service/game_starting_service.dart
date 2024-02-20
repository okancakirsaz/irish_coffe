import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/core/consts/app_consts.dart';
import 'package:irish_coffe/core/init/network_manager.dart';

import '../../public_models/game_room_model.dart';

final class GameStartingService extends NetworkManager {
  Future<GameRoomModel?> createGameRoom(GameRoomModel data) async {
    try {
      final response = await network.post(AppConst.instance.createGameRoom,
          data: data.toJson());
      return GameRoomModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
