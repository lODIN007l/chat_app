import 'package:aoo_chat_live/global/enviroment.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  //LLAMAMOS DESDE CUALQUIER LADO Y SABREMOS SI ESTA CON CONEXION
  late IO.Socket _socket;
  ServerStatus get serverStatusG => this._serverStatus;
  IO.Socket get socketG => this._socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await AutenticacionService.getToken();
    _socket = IO.io(
        Enviroment.socketUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableForceNew()
            .setExtraHeaders({'x-token': token})
            .build());

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      //opcional
      _socket.emit('mensaje', 'conectado desde app Flutter');
      notifyListeners();
      print('connect');
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
      print('disconnect');
    });
  }

  void desconectar() {
    _socket.disconnect();
  }
}
