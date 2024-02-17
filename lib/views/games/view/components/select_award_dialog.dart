part of '../games_view.dart';

class SelectAwardDialog extends StatelessWidget {
  final CurrentlyInIrishModel targetUser;
  final String gameName;
  final GamesViewModel viewModel;
  const SelectAwardDialog(
      {super.key,
      required this.viewModel,
      required this.targetUser,
      required this.gameName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConsts.instance.darkGrey,
      content: FutureBuilder(
          future: viewModel.fetchMenuItemsInDropdown(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildDropdown(snapshot.data!),
                    Padding(
                      padding: PaddingConsts.instance.top10,
                      child: buildCountRow(),
                    ),
                    Padding(
                      padding: PaddingConsts.instance.top10,
                      child: CustomButton(
                          onPressed: () => viewModel.inviteUserToGame(
                              targetUser, gameName, viewModel),
                          style: TextConsts.instance.regularBlack18Bold,
                          text: "Davet Et",
                          width: 200,
                          height: 50),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorConsts.instance.lightGray,
                ),
              );
            }
          }),
    );
  }

  Widget buildDropdown(List<DropdownMenuEntry> snapshotData) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConsts.instance.lightGray,
          borderRadius: RadiusConsts.instance.circularAll10),
      child: DropdownMenu(
        hintText: "Nesine?",
        dropdownMenuEntries: snapshotData,
        controller: viewModel.selectAwardDialogController,
      ),
    );
  }

  Widget buildCountRow() {
    return SizedBox(
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildFloatButton(
              Icons.remove, () => viewModel.decrementSelectedItemCount()),
          Observer(builder: (context) {
            return Text(
              viewModel.selectedItemCount.toString(),
              style: TextConsts.instance.regularWhite25Bold,
            );
          }),
          buildFloatButton(
              Icons.add, () => viewModel.incrementSelectedItemCount()),
        ],
      ),
    );
  }

  Widget buildFloatButton(IconData icon, VoidCallback onPressed) {
    return FloatingActionButton(
      backgroundColor: ColorConsts.instance.orange,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: 30,
        color: ColorConsts.instance.lightGray,
      ),
    );
  }
}
