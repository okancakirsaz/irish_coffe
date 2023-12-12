part of '../profile_view.dart';

class FavoriteFoods extends StatelessWidget {
  final ProfileViewModel viewModel;
  const FavoriteFoods({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return foods(viewModel);
  }

  Widget haventData() {
    return Padding(
      padding: PaddingConsts.instance.all10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: Svg(AssetConsts.instance.beer),
          ),
          Text(
            "Bu kullanıcı henüz sipariş vermemiş",
            style: TextConsts.instance.regularBlack25Bold,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget foods(ProfileViewModel viewModel) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: PaddingConsts.instance.all5,
          child: ListTile(
            title: Text(
              "Irish Coffee",
              style: TextConsts.instance.regularBlack18Bold,
            ),
            subtitle: Text(
              "x10",
              style: TextConsts.instance.regularBlack14Bold,
            ),
            trailing: Image.network(
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                "https://i.pinimg.com/236x/d4/6c/54/d46c545effbcadc65546b9a6d3ba8697.jpg"),
          ),
        );
      },
    );
  }
}
