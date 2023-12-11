part of '../menu_view.dart';

class MenuItem extends StatelessWidget {
  final MenuItemModel data;
  final MenuViewModel viewModel;
  const MenuItem({super.key, required this.data, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (context) => AddToBasketDialog(
                viewModel: viewModel,
                data: data,
              )),
      child: Container(
        padding: PaddingConsts.instance.bottom25,
        margin: PaddingConsts.instance.all5,
        decoration: BoxDecoration(
            borderRadius: RadiusConsts.instance.circularAll10,
            color: ColorConsts.instance.green,
            boxShadow: ColorConsts.instance.shadow),
        child: Column(
          children: <Widget>[elementImage(), Expanded(child: elementInfo())],
        ),
      ),
    );
  }

  Widget elementImage() {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularTop10,
        image:
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(data.img!)),
      ),
    );
  }

  Widget elementInfo() {
    return ListTile(
      title: Text(
        data.name!,
        style: TextConsts.instance.regularWhite25Bold,
      ),
      trailing: Text(
        data.price!,
        style: TextConsts.instance.regularWhite25Bold,
      ),
      subtitle: Text(
        data.materials!.join(", "),
        style: TextConsts.instance.regularWhite16,
      ),
    );
  }
}
