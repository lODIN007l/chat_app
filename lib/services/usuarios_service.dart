import 'package:aoo_chat_live/global/enviroment.dart';
import 'package:aoo_chat_live/models/usuarios_respuesta.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:aoo_chat_live/models/usuario.dart';

class UsuarioServicio with ChangeNotifier {
  Future<List<Usuario>> getUsuario() async {
    try {
      final uri = Uri.parse(
        '${Enviroment.apiUrl}/usuarios',
      );

      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': await AutenticacionService.getToken()
      });
      final usuarioResp = usuarioResponseFromJson(resp.body);

      return usuarioResp.usuarioDb;
    } catch (error) {
      return [];
    }
  }
}
