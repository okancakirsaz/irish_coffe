part of '../menu_view.dart';

class Basket extends StatelessWidget {
  final MenuViewModel viewModel;
  const Basket({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          backgroundColor: ColorConsts.instance.lightGray,
          title: Text(
            "Sepetim",
            style: TextConsts.instance.regularBlack25Bold,
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child:
                    viewModel.basket.isNotEmpty ? basketList() : basketEmpty()),
            Padding(
              padding: PaddingConsts.instance.bottom50,
              child: CustomStateFullButton(
                onPressed: () async => await viewModel.bucketVerification(),
                style: TextConsts.instance.regularBlack18,
                text: "Sepeti Onayla",
                width: 200,
                height: 50,
              ),
            ),
          ],
        ));
  }

  Widget basketList() {
    return Observer(builder: (context) {
      return ListView.builder(
          itemCount: viewModel.basket.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  viewModel.basket[index]["element"].name!,
                  style: TextConsts.instance.regularBlack18Bold,
                ),
                subtitle: Text(
                  "${viewModel.calculateElementPrice(index)}₺",
                  style: TextConsts.instance.regularBlack14Bold,
                ),
                leading: Text(
                  "x${viewModel.basket[index]["count"]}",
                  style: TextConsts.instance.regularBlack18Bold,
                ),
                trailing: IconButton(
                  onPressed: () => viewModel.deleteElementFromBasket(index),
                  icon: Icon(
                    Icons.delete,
                    color: ColorConsts.instance.red,
                    size: 35,
                  ),
                ),
              ),
            );
          });
    });
  }

  Widget basketEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          AssetConsts.instance.beer,
          width: 150,
        ),
        const SizedBox(height: 40),
        Text(
          "Sepetiniz boş. Menüden bir şeyler ekleyebilirsiniz.",
          style: TextConsts.instance.regularBlack25Bold,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
