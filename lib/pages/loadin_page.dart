// ignore_for_file: use_build_context_synchronously

import 'package:aoo_chat_live/pages/login_page.dart';
import 'package:aoo_chat_live/pages/usuarios_page.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ((context, snapshot) {
          return const Center(
            child: Text('Espere'),
          );
        }),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authServicio =
        Provider.of<AutenticacionService>(context, listen: false);
    final autenticadoK = await authServicio.isLogguedin();
    if (autenticadoK) {
      //Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosScreen(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginScreen(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}
