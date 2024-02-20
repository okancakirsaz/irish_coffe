import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/mock_game/viewmodel/mock_game_viewmodel.dart';

class MockGameView extends StatelessWidget {
  final DuelInviteModel duelData;
  const MockGameView({super.key, required this.duelData});

  @override
  Widget build(BuildContext context) {
    return BaseView<MockGameViewModel>(
      viewModel: MockGameViewModel(),
      onPageBuilder: (context, model) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.incrementScore(),
            child: const Icon(Icons.add),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(builder: (context) {
                return Text(
                  'Kalan süre: ${model.timerSeconds}',
                  style: TextConsts.instance.regularBlack18Bold,
                );
              }),
              Observer(builder: (context) {
                return Center(
                  child: Text(
                    model.score.toString(),
                    style: TextConsts.instance.regularBlack36Bold,
                  ),
                );
              }),
            ],
          ),
        );
      },
      onModelReady: (model) {
        model.setContext(context);
        model.initDuelData(duelData);
        model.init();
      },
      onDispose: () {},
    );
  }
}
