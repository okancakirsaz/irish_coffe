part of '../community_view.dart';

class CustomerList extends StatelessWidget {
  final CommunityViewModel viewModel;
  const CustomerList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (viewModel.customers.isNotEmpty && viewModel.isDataLoadSuccessful) {
        return buildCustomerList();
      } else if (viewModel.customers.isEmpty &&
          viewModel.isDataLoadSuccessful) {
        return buildNobodyHereWidget();
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: ColorConsts.instance.orange,
          ),
        );
      }
    });
  }

  Widget buildCustomerList() {
    return RefreshIndicator(
      color: ColorConsts.instance.orange,
      backgroundColor: ColorConsts.instance.lightGray,
      onRefresh: () async => await viewModel.getCustomerList(),
      child: Observer(builder: (context) {
        return ListView.builder(
            itemCount: viewModel.customers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => viewModel.checkUserIsAnonymAndNavigateProfile(
                    viewModel.customers[index]),
                child: Card(
                  child: ListTile(
                    title: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      viewModel.customers[index].isAnonym
                          ? "Anonim"
                          : viewModel.customers[index].name,
                      style: TextConsts.instance.regularBlack18,
                    ),
                    trailing: SvgPicture.asset(
                        width: 40,
                        viewModel.customers[index].isAnonym
                            ? AssetConsts.instance.profile
                            : viewModel.customers[index].gender == "Kadın"
                                ? AssetConsts.instance.woman
                                : AssetConsts.instance.man),
                  ),
                ),
              );
            });
      }),
    );
  }

  Widget buildNobodyHereWidget() {
    return RefreshIndicator(
      color: ColorConsts.instance.orange,
      backgroundColor: ColorConsts.instance.lightGray,
      onRefresh: () async => await viewModel.getCustomerList(),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(AssetConsts.instance.pipe),
              const SizedBox(height: 15),
              Text(
                "Henüz kimse yok.",
                style: TextConsts.instance.regularBlack25Bold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
