import 'package:flutter/cupertino.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';

import '../../../core/consts/app_consts.dart';

final class GameAndEventPublicService extends NetworkManager {
  Future<GameRoomModel?> setGameRoom(
      GameRoomModel data, String endpoint) async {
    try {
      final response = await network.post(endpoint, data: data.toJson());
      return GameRoomModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<GameRoomModel?> getGameRoom(DuelInviteModel data) async {
    try {
      final response = await network.post(AppConst.instance.getGameRoom,
          data: data.toJson());
      return GameRoomModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
