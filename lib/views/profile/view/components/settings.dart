part of '../profile_view.dart';

class Settigns extends StatelessWidget {
  final ProfileViewModel viewModel;
  const Settigns({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConsts.instance.green,
      appBar: CustomAppBar(
        title: Text(
          "Ayarlar",
          style: TextConsts.instance.regularWhite20Bold,
        ),
      ).build(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ProfileImage(viewModel: viewModel),
              Column(
                children: <Widget>[
                  buildSpecialButton(() => viewModel.openImageModeSelector(),
                      "Fotoğrafı Değiştir"),
                  buildSpecialButton(() => viewModel.showSureDialog(() {}),
                      "Fotoğrafı Kaldır"),
                ],
              ),
            ],
          ),
          Padding(
            padding: PaddingConsts.instance.all5,
            child: buildSpecialTextField(viewModel.nameController),
          ),
          Padding(
            padding: PaddingConsts.instance.all5,
            child: buildSpecialTextField(viewModel.mailController),
          ),
          Padding(
            padding: PaddingConsts.instance.all10,
            child: specialSwitch(viewModel),
          ),
          buildSpecialButton(() async => await viewModel.logOut(), "Çıkış Yap"),
          buildSpecialButton(
              () => viewModel.showSureDialog(() {}), "Hesabı Sil"),
          const SizedBox(height: 30),
          CustomButton(
              onPressed: () {},
              style: TextConsts.instance.regularBlack20,
              text: "Kaydet",
              width: 200,
              height: 40)
        ],
      ),
    );
  }

  Widget buildSpecialTextField(TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.orange, width: 2),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.orange, width: 2),
        ),
      ),
      cursorColor: ColorConsts.instance.orange,
      style: TextConsts.instance.regularWhite20,
      controller: controller,
    );
  }

  Widget buildSpecialButton(VoidCallback onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(ColorConsts.instance.orange),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: RadiusConsts.instance.circularAll10),
        ),
      ),
      child: Text(
        text,
        style: TextConsts.instance.regularWhite16Bold,
      ),
    );
  }

  Widget specialSwitch(ProfileViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Observer(builder: (context) {
          return Switch(
            activeColor: ColorConsts.instance.orange,
            value: viewModel.anonymValue ?? false,
            onChanged: (value) async =>
                await viewModel.changeAnonymValue(value),
          );
        }),
        SizedBox(
          width: 200,
          child: Text(
            "Kimler Irish'te kısmında gözükmek istemiyorum.",
            style: TextConsts.instance.regularWhite14Bold,
          ),
        ),
      ],
    );
  }
}