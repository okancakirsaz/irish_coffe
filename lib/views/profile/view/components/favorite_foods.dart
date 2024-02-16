part of '../profile_view.dart';

class FavoriteFoods extends StatelessWidget {
  final ProfileViewModel viewModel;
  const FavoriteFoods({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavoreiteFoodsModel>>(
      future: viewModel.getUserFavoriteFoods(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return foods(snapshot.data!);
          } else {
            return haventData();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget haventData() {
    return Padding(
      padding: PaddingConsts.instance.all10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(AssetConsts.instance.beer),
          Text(
            "Bu kullanıcı henüz sipariş vermemiş",
            style: TextConsts.instance.regularBlack25Bold,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget foods(List<FavoreiteFoodsModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        return Card(
          margin: PaddingConsts.instance.all5,
          child: ListTile(
            title: Text(
              snapshot[index].foodName,
              style: TextConsts.instance.regularBlack18Bold,
            ),
            subtitle: Text(
              "x${snapshot[index].count}",
              style: TextConsts.instance.regularBlack14Bold,
            ),
            trailing: Image.network(
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                snapshot[index].photo),
          ),
        );
      },
    );
  }
}
