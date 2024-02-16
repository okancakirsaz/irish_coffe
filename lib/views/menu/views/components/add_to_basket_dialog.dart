part of '../menu_view.dart';

class AddToBasketDialog extends StatelessWidget {
  final MenuItemModel data;
  final MenuViewModel viewModel;
  const AddToBasketDialog(
      {super.key, required this.data, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConsts.instance.darkGrey,
      title: ListTile(
          title: Text(
            data.name!,
            style: TextConsts.instance.regularWhite25Bold,
          ),
          trailing: Text(
            data.price!,
            style: TextConsts.instance.regularWhite25Bold,
          )),
      content: SizedBox(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            countRow(),
            CustomButton(
                onPressed: () => viewModel.addElementToBasket(data),
                style: TextConsts.instance.regularBlack20,
                text: "Sepete Ekle",
                width: 200,
                height: 50),
          ],
        ),
      ),
    );
  }

  Widget countRow() {
    return SizedBox(
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          floatButton(
              Icons.remove, () => viewModel.decramentSelectedItemCount()),
          Observer(builder: (context) {
            return Text(
              viewModel.selectedItemCount.toString(),
              style: TextConsts.instance.regularWhite25Bold,
            );
          }),
          floatButton(Icons.add, () => viewModel.incrementSelectedItemCount()),
        ],
      ),
    );
  }

  Widget floatButton(IconData icon, VoidCallback onPressed) {
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
