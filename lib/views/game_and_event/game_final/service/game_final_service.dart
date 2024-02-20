import 'package:flutter/material.dart';
import 'package:irish_coffe/core/init/network_manager.dart';
import 'package:irish_coffe/views/profile/models/scores_model.dart';

import '../../../../core/consts/app_consts.dart';

final class GameFinalService extends NetworkManager {
  Future<ScoresModel?> setUserScore(ScoresModel data) async {
    try {
      final response = await network.post(AppConst.instance.updateUserScores,
          data: data.toJson());
      return ScoresModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
