import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:aoo_chat_live/global/enviroment.dart';
import 'package:aoo_chat_live/models/login_response.dart';
import 'package:aoo_chat_live/models/usuario.dart';

class AutenticacionService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;
  // Create storage
  final _storage = FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  //getters del token de ofmra statica
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );
    //print(resp.body);
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResp = loginResponseFromJson(resp.body);
      usuario = loginResp.usuario;
      await _guardarToken(loginResp.token);

      return true;
    } else {
      //print('no se pudo enviar a usuario ');
      return false;
    }
  }

  Future _guardarToken(String token) async {
    // guardamos el token
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async {
    // guardamos el token
    await _storage.delete(key: 'token');
  }

  Future register(String nombre, String email, String password) async {
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };
    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );

    //print(resp.body);
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResp = loginResponseFromJson(resp.body);
      usuario = loginResp.usuario;
      await _guardarToken(loginResp.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      //final respuestaE = ;
      return respBody['msg'];
    }
  }

  Future<bool> isLogguedin() async {
    final token = await this._storage.read(key: 'token') ?? '';
    final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');
    final resp = await http.get(
      uri,
      headers: {
        'Content-type': 'application/json',
        'x-token': token,
      },
    );

    //print(resp.body);
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResp = loginResponseFromJson(resp.body);
      usuario = loginResp.usuario;
      await _guardarToken(loginResp.token);
      return true;
    } else {
      this._logout();
      //final respuestaE = ;
      return false;
    }
  }
}
