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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: PaddingConsts.instance.right10,
                  child: ProfileImage(viewModel: viewModel),
                ),
                Column(
                  children: <Widget>[
                    buildSpecialButton(() => viewModel.openImageModeSelector(),
                        "Fotoğrafı Değiştir"),
                    buildSpecialButton(
                        () => viewModel.showSureDialog(
                            () async => await viewModel.deleteProfileImage()),
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
              padding: PaddingConsts.instance.all5,
              child: buildSpecialTextField(
                  viewModel.numberController, TextInputType.phone),
            ),
            Padding(
              padding: PaddingConsts.instance.all10,
              child: specialSwitch(viewModel),
            ),
            buildSpecialButton(
                () async => await viewModel.sendResetPasswordEmail(),
                "Şifreyi Değiştir"),
            buildSpecialButton(
                () async => await viewModel.logOut(), "Çıkış Yap"),
            // buildSpecialButton(
            //     () => viewModel.showSureDialog(
            //         () async => await viewModel.deleteAccount()),
            //     "Hesabı Sil"),
            const SizedBox(height: 30),
            CustomButton(
                onPressed: () async => await viewModel.setNewUserSettings(),
                style: TextConsts.instance.regularBlack20,
                text: "Kaydet",
                width: 200,
                height: 40)
          ],
        ),
      ),
    );
  }

  Widget buildSpecialTextField(TextEditingController controller,
      [TextInputType? type]) {
    return TextFormField(
      inputFormatters:
          type == TextInputType.phone || type == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
      keyboardType: type,
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

  Widget buildSpecialPasswordField(
    TextEditingController controller,
  ) {
    return PasswordField(
      color: ColorConsts.instance.orange,
      border: PasswordBorder(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.orange, width: 2),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.orange, width: 2),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.orange, width: 2),
        ),
      ),
      errorMessage: "",
      passwordDecoration: PasswordDecoration(
        inputStyle: TextConsts.instance.regularWhite20,
      ),
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
