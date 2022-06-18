import 'package:aoo_chat_live/widgets/custom_buttton.dart';
import 'package:aoo_chat_live/widgets/custom_input.dart';
import 'package:aoo_chat_live/widgets/label.dart';
import 'package:aoo_chat_live/widgets/logo_app.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LogoApp(titulo1: 'Messenger'),
                  _FormState(),
                  const LabelWidget(
                    text1: 'No tienes cuenta?',
                    text2: 'CREA UNA AHORA!',
                    ruta: 'registro',
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: const Text(
                      'Terminos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _FormState extends StatefulWidget {
  @override
  State<_FormState> createState() => __FormStateState();
}

class __FormStateState extends State<_FormState> {
  final emailControlador = TextEditingController();
  final passwordControlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            ico: Icons.mail_outline,
            placeholder: 'Correo',
            keybTipo: TextInputType.emailAddress,
            textcontrolador: emailControlador,
          ),
          CustomInput(
            ico: Icons.lock_outline,
            placeholder: 'Password',
            isPassword: true,
            textcontrolador: passwordControlador,
          ),
          CustomButton(
            text1: 'Ingrese',
            onpress1: () {
              print(emailControlador.text);
              print(passwordControlador.text);
            },
          ),
        ],
      ),
    );
  }
}
