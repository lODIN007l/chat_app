// To parse this JSON data, do
//
//     final usuarioResponse = usuarioResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aoo_chat_live/models/usuario.dart';

UsuarioResponse usuarioResponseFromJson(String str) =>
    UsuarioResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) =>
    json.encode(data.toJson());

class UsuarioResponse {
  UsuarioResponse({
    required this.ok,
    required this.usuarioDb,
  });

  bool ok;
  List<Usuario> usuarioDb;

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) =>
      UsuarioResponse(
        ok: json["ok"],
        usuarioDb: List<Usuario>.from(
            json["usuarioDB"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarioDB": List<dynamic>.from(usuarioDb.map((x) => x.toJson())),
      };
}
