part of '../games_view.dart';

class Events extends StatelessWidget {
  final GamesViewModel viewModel;
  const Events({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchEventsToWidget(),
        builder: (context, snapshot) {
          return viewModel.eventsAsWidget.isNotEmpty
              ? eventsIsAvailable(snapshot)
              : eventsIsNotAvailableNow();
        });
  }

  Widget eventsIsAvailable(AsyncSnapshot<List<Widget>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return snapshot.data![index];
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

Widget eventsIsNotAvailableNow() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        AssetConsts.instance.event,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
      ),
      Text(
        "Şuan aktif etkinlik bulunmamakta.",
        style: TextConsts.instance.regularBlack20Bold,
      ),
    ],
  );
}
