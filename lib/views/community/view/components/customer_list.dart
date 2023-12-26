part of '../community_view.dart';

class CustomerList extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CustomerList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CurrentlyInIrishModel>?>(
        future: viewModel.getCustomerList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () =>
                            viewModel.checkUserIsAnonymAndNavigateProfile(
                                snapshot.data![index]),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              snapshot.data![index].isAnonym
                                  ? "Anonim"
                                  : snapshot.data![index].name,
                              style: TextConsts.instance.regularBlack18,
                            ),
                            trailing: SvgPicture.asset(
                                width: 40,
                                snapshot.data![index].isAnonym
                                    ? AssetConsts.instance.profile
                                    : snapshot.data![index].gender == "Kadın"
                                        ? AssetConsts.instance.woman
                                        : AssetConsts.instance.man),
                          ),
                        ),
                      );
                    })
                : buildNobodyHereWidget();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildNobodyHereWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(AssetConsts.instance.pipe),
        const SizedBox(height: 15),
        Text(
          "Henüz kimse yok.",
          style: TextConsts.instance.regularBlack25Bold,
        )
      ],
    );
  }
}
