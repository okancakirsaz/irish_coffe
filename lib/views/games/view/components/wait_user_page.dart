part of '../games_view.dart';

class WaitUserPage extends StatelessWidget {
  final GamesViewModel viewModel;
  final DuelInviteModel data;

  const WaitUserPage({super.key, required this.viewModel, required this.data});

  @override
  Widget build(BuildContext context) {
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
              data.gameName,
              style: TextConsts.instance.regularBlack25Bold,
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.all20,
            child: buildUserDatasRow(),
          ),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: buildTimer(),
          ),
          Padding(
            padding: PaddingConsts.instance.all20,
            child: Text(
              "Ödül: ${data.itemName} ${data.itemName == "Ödülsüz" ? '' : 'x${data.itemCount}'}",
              style: TextConsts.instance.regularBlack18,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserDatasRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            buildUserPhoto(data.challengerUserProfileImage, true),
            SizedBox(
              width: 100,
              child: Text(
                data.challengerUserName,
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
            buildUserPhoto(data.challengedUserProfileImage, false),
            SizedBox(
              width: 100,
              child: Text(
                data.challengedUserName,
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

  Widget buildUserPhoto(String? photoUrl, bool isChallenger) {
    if (photoUrl == null) {
      return Container(
        width: 70,
        height: 70,
        child: SvgPicture.asset(
          viewModel.pickImageForGender(viewModel.pickImageForGender(isChallenger
              ? data.challengerUserGender
              : data.challengedUserGender)),
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

  Widget buildTimer() {
    return Center(
      child: CircularCountDownTimer(
          width: 200,
          height: 200,
          strokeCap: StrokeCap.round,
          textStyle: TextConsts.instance.regularWhite25Bold,
          duration: 120,
          isReverse: true,
          isReverseAnimation: true,
          strokeWidth: 20,
          backgroundColor: ColorConsts.instance.orange,
          fillColor: ColorConsts.instance.green,
          ringColor: Colors.transparent),
    );
  }
}
