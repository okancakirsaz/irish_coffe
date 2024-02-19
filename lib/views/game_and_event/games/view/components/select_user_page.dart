part of '../games_view.dart';

class SelectUserPage extends StatelessWidget {
  final String gameName;
  final GamesViewModel viewModel;
  const SelectUserPage(
      {super.key, required this.gameName, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rakip Seçiniz",
          style: TextConsts.instance.regularBlack25Bold,
        ),
      ),
      body: FutureBuilder(
          future: viewModel.getActiveUsers(),
          builder: (context, snapshot) {
            switch (snapshot.hasData) {
              case true:
                return buildUsersList(snapshot.data!);

              default:
                return Center(
                  child: CircularProgressIndicator(
                      color: ColorConsts.instance.orange),
                );
            }
          }),
    );
  }

  Widget buildUsersList(List<CurrentlyInIrishModel> snapshotData) {
    return ListView.builder(
        itemCount: snapshotData.length,
        itemBuilder: (context, index) {
          final CurrentlyInIrishModel item = snapshotData[index];
          return !viewModel.isUserCanListInSelectUserPage(
                  item.name, item.isAnonym)
              ? null
              : Card(
                  child: ListTile(
                    onTap: () async => await viewModel.showSelectAwardDialog(
                        gameName, viewModel, item),
                    title: Text(item.name,
                        style: TextConsts.instance.regularBlack20Bold),
                  ),
                );
        });
  }
}
