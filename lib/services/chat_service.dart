import 'package:aoo_chat_live/models/mensajes_response.dart';
import 'package:aoo_chat_live/models/usuario.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class ChatServicio with ChangeNotifier {
  Usuario? usuarioDestino;

  Future<List<Mensaje>> obtenerChat(String usuarioID) async {
    final uri = Uri.parse(
      '${Enviroment.apiUrl}/mensajes/$usuarioID',
    );
    final resp = await http.get(uri, headers: {
      'content-Type': 'application/json',
      'x-token': await AutenticacionService.getToken()
    });

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;
  }
}
