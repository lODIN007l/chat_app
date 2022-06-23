// ignore_for_file: use_build_context_synchronously

import 'package:aoo_chat_live/helpers/mostrar_alerta.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:aoo_chat_live/widgets/custom_buttton.dart';
import 'package:aoo_chat_live/widgets/custom_input.dart';
import 'package:aoo_chat_live/widgets/label.dart';
import 'package:aoo_chat_live/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // ignore: sized_box_for_whitespace
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
    final authServicio =
        Provider.of<AutenticacionService>(context, listen: false);

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
            onpress1: authServicio.autenticando
                // ignore: avoid_returning_null_for_void
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOK = await authServicio.login(
                      emailControlador.text.trim(),
                      passwordControlador.text.trim(),
                    );
                    if (loginOK) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //Mostrar alerta
                      mostrarAlerta(context, 'Error',
                          'Revise los datos ingresados', Colors.blue);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
