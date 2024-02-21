import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/public_managers/websocket_manager.dart';
import 'package:irish_coffe/views/game_and_event/games/models/duel_invite_model.dart';
import 'package:irish_coffe/views/game_and_event/user_waiting/viewmodel/user_waiting_viewmodel.dart';

import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/text_consts.dart';

class UserWaitingView extends StatelessWidget {
  final DuelInviteModel duel;
  const UserWaitingView({super.key, required this.duel});

  @override
  Widget build(BuildContext context) {
    return BaseView<UserWaitingViewModel>(
      viewModel: UserWaitingViewModel(),
      onPageBuilder: (context, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Kullanıcıdan cevap bekleniyor...",
              style: TextConsts.instance.regularBlack20Bold,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: PaddingConsts.instance.bottom40,
                child: Text(
                  duel.gameName,
                  style: TextConsts.instance.regularBlack25Bold,
                ),
              ),
              Padding(
                padding: PaddingConsts.instance.all20,
                child: buildUserDatasRow(model),
              ),
              Padding(
                padding: PaddingConsts.instance.top10,
                child: buildTimer(model),
              ),
              Padding(
                padding: PaddingConsts.instance.all20,
                child: Text(
                  "Ödül: ${duel.itemName} ${duel.itemName == "Ödülsüz" ? '' : 'x${duel.itemCount}'}",
                  style: TextConsts.instance.regularBlack18,
                ),
              ),
            ],
          ),
        );
      },
      onModelReady: (model) {
        model.setContext(context);
        model.initDuelData(duel);
        model.init();
      },
      onDispose: () {
        WebSocketManager.instance.disconnectFromSocket();
      },
    );
  }

  Widget buildUserDatasRow(UserWaitingViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            buildUserPhoto(duel.challengerUserProfileImage, true, model),
            SizedBox(
              width: 100,
              child: Text(
                duel.challengerUserName,
                style: TextConsts.instance.regularBlack16,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
        Text(
          "VS",
          style: TextConsts.instance.regularBlack36Bold,
        ),
        Column(
          children: <Widget>[
            buildUserPhoto(duel.challengedUserProfileImage, false, model),
            SizedBox(
              width: 100,
              child: Text(
                duel.challengedUserName,
                style: TextConsts.instance.regularBlack16,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildUserPhoto(
      String? photoUrl, bool isChallenger, UserWaitingViewModel model) {
    if (photoUrl == null) {
      return SizedBox(
        width: 70,
        height: 70,
        child: SvgPicture.asset(
          model.pickImageForGender(
            isChallenger
                ? duel.challengerUserGender
                : duel.challengedUserGender,
          ),
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(photoUrl))),
      );
    }
  }

  Widget buildTimer(UserWaitingViewModel model) {
    return Center(
      child: CircularCountDownTimer(
        width: 200,
        height: 200,
        strokeCap: StrokeCap.round,
        textStyle: TextConsts.instance.regularWhite25Bold,
        duration: 60,
        isReverse: true,
        isReverseAnimation: true,
        strokeWidth: 20,
        backgroundColor: ColorConsts.instance.orange,
        fillColor: ColorConsts.instance.green,
        ringColor: Colors.transparent,
        onComplete: () async => await model.onTimeOut(),
      ),
    );
  }
}
