import 'package:aoo_chat_live/pages/chat_page.dart';
import 'package:aoo_chat_live/pages/loadin_page.dart';
import 'package:aoo_chat_live/pages/login_page.dart';
import 'package:aoo_chat_live/pages/registe_page.dart';
import 'package:aoo_chat_live/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRutas = {
  'usuarios': (_) => UsuariosScreen(),
  'chat': (_) => ChatScreen(),
  'login': (_) => LoginScreen(),
  'registro': (_) => RegisterScreen(),
  'loading': (_) => LoadingScreen(),
};
