import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_coffe/views/game_and_event/bird_hunter/viewmodel/bird_hunter_viewmodel.dart';

import '../../../../../core/consts/asset_consts.dart';

class BirdView extends StatelessWidget {
  final BirdHunterViewModel viewModel;
  const BirdView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    viewModel.createRandomParrotPosition();
    viewModel.scaleIncrementLoop(viewModel);
    return Observer(builder: (context) {
      return Align(
        alignment: viewModel.birdAlignment!,
        child: Transform.scale(
          scale: viewModel.birdScale,
          child: Transform.rotate(
            angle: viewModel.birdAngle,
            child: InkWell(
              onTap: () => viewModel.shootTheBird(viewModel),
              child: Image.asset(AssetConsts.instance.parrot),
            ),
          ),
        ),
      );
    });
  }
}
