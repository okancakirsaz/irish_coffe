part of '../profile_view.dart';

class GameScors extends StatelessWidget {
  final ProfileViewModel viewModel;
  const GameScors({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScoresModel>>(
      future: viewModel.getUserScores(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return scores(snapshot.data!);
          } else {
            return didntPlayedGame();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget didntPlayedGame() {
    return Padding(
      padding: PaddingConsts.instance.all10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: Svg(AssetConsts.instance.snake),
          ),
          Text(
            "Bu kullanıcı daha önce hiç oyun oynamamış :(",
            style: TextConsts.instance.regularBlack25Bold,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget scores(List<ScoresModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        return Card(
          margin: PaddingConsts.instance.all5,
          child: ListTile(
            title: Text(
              "${snapshot[index].userName} VS ${snapshot[index].challengedUserName}",
              style: TextConsts.instance.regularGreen14Bold,
            ),
            subtitle: Text(
              snapshot[index].game,
              style: TextConsts.instance.regularBlack12,
            ),
            trailing: SizedBox(
              height: 50,
              child: Column(
                children: <Widget>[
                  Image(
                    width: 30,
                    height: 30,
                    image: Svg(
                      snapshot[index].isWinned
                          ? AssetConsts.instance.rainbow
                          : AssetConsts.instance.pipe,
                    ),
                  ),
                  Text(
                    snapshot[index].isWinned ? "Kazandı" : "Kaybetti",
                    style: TextConsts.instance.regularBlack14Bold,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
