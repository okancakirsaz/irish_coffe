part of '../profile_view.dart';

class GameScors extends StatelessWidget {
  final ProfileViewModel viewModel;
  const GameScors({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return scores(viewModel);
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

  Widget scores(ProfileViewModel viewModel) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: PaddingConsts.instance.all5,
          child: ListTile(
            title: Text(
              "${viewModel.userName} VS Volkan Konak",
              style: TextConsts.instance.regularGreen14Bold,
            ),
            subtitle: Text(
              "Yılan ve Yonca",
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
                      index % 2 == 0
                          ? AssetConsts.instance.rainbow
                          : AssetConsts.instance.pipe,
                    ),
                  ),
                  Text(
                    index % 2 == 0 ? "Kazandı" : "Kaybetti",
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
