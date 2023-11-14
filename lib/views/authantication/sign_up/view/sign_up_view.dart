import 'package:flutter/material.dart';
import 'package:irish_coffe/core/base/view/base_view.dart';
import 'package:irish_coffe/core/consts/asset_consts.dart';
import 'package:irish_coffe/core/consts/padding_consts.dart';
import 'package:irish_coffe/core/consts/text_consts.dart';
import 'package:irish_coffe/core/widgets/custom_button.dart';
import 'package:irish_coffe/core/widgets/pop_button.dart';
import 'package:irish_coffe/views/authantication/core/components/auth_text_field.dart';
import 'package:irish_coffe/views/authantication/core/components/logo_view_auth.dart';
import 'package:irish_coffe/views/authantication/core/components/title.dart';
import '../../../../core/consts/color_consts/color_consts.dart';
import '../viewmodel/sign_up_viewmodel.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
        viewModel: SignUpViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AssetConsts.instance.backgroundImage))),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      buildLoginArea(model, context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: () {});
  }

  Widget buildLoginArea(SignUpViewModel model, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConsts.instance.green),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PopButton(style: TextConsts.instance.regularWhite20),
          const SizedBox(height: 10),
          const Center(child: LogoViewAuth()),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "İsim Soyisim")),
          const SizedBox(height: 5),
          AuthTextField(
            controller: model.nameController,
          ),
          const SizedBox(height: 10),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "Telefon Numarası")),
          const SizedBox(height: 5),
          AuthTextField(
            inputType: TextInputType.phone,
            controller: model.numberController,
          ),
          const SizedBox(height: 10),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "E-Posta")),
          const SizedBox(height: 5),
          AuthTextField(
            inputType: TextInputType.emailAddress,
            controller: model.emailController,
          ),
          const SizedBox(height: 10),
          Padding(
              padding: PaddingConsts.instance.left30,
              child: const CustomTitle(text: "Şifre")),
          const SizedBox(height: 5),
          AuthTextField(
            inputType: TextInputType.visiblePassword,
            controller: model.passwordController,
          ),
          const SizedBox(height: 20),
          Center(
            child: CustomButton(
                onPressed: () async => await model.createMembership(),
                style: TextConsts.instance.regularBlack25Bold,
                text: "Hesap Oluştur",
                width: 245,
                height: 50),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
