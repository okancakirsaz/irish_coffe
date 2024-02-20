import 'package:flutter/material.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/color_consts/color_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/views/game_and_event/game_final/viewmodel/game_final_viewmodel.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/public_models/game_room_model.dart';

part 'components/you_lose_page.dart';
part 'components/you_win_page.dart';
part 'components/draw_page.dart';

class GameFinalView extends StatelessWidget {
  final GameRoomModel roomData;
  final DuelInviteModel duelData;
  const GameFinalView(
      {super.key, required this.roomData, required this.duelData});

  @override
  Widget build(BuildContext context) {
    return BaseView<GameFinalViewModel>(
      viewModel: GameFinalViewModel(),
      onPageBuilder: (context, model) {
        return Scaffold(
          backgroundColor: model.isUserWonTheGame
              ? ColorConsts.instance.green
              : ColorConsts.instance.orange,
          body: model.winnerUserScore == model.loserUserScore
              ? DrawPage(viewModel: model)
              : model.isUserWonTheGame
                  ? YouWinPage(viewModel: model)
                  : YouLosePage(
                      viewModel: model,
                    ),
        );
      },
      onModelReady: (model) {
        model.initCameData(roomData, duelData);
        model.setContext(context);
        model.init();
      },
      onDispose: () {},
    );
  }
}
