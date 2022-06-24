import 'dart:io';

import 'package:aoo_chat_live/models/mensajes_response.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:aoo_chat_live/services/sockt_service.dart';
import 'package:aoo_chat_live/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textCtrl = TextEditingController();
  final _focusNode = FocusNode();
  AutenticacionService? authServ;
  ChatServicio? chatServ;
  SocketService? socketServ;

  final List<ChatMessage> _mensaje = [];

  bool estaescribiendo = false;

  @override
  void initState() {
    super.initState();
    chatServ = Provider.of<ChatServicio>(context, listen: false);
    socketServ = Provider.of<SocketService>(context, listen: false);
    authServ = Provider.of<AutenticacionService>(context, listen: false);

    socketServ!.socketG
        .on('mensaje-personal', (data) => _escucharmensaje(data));

    _cargarHistorial(chatServ!.usuarioDestino!.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje>? chat = await chatServ?.obtenerChat(usuarioID);

    //print(chat);

    final historial = chat!.map(
      (mess) => ChatMessage(
        textoCh: mess.mensaje,
        uid: mess.emisor,
        animacion: AnimationController(
          vsync: this,
          duration: const Duration(microseconds: 0),
        )..forward(),
      ),
    );
    setState(() {
      _mensaje.insertAll(0, historial);
    });
  }

  void _escucharmensaje(dynamic payload) {
    print('tengo mensaje $payload');
    ChatMessage message = ChatMessage(
      textoCh: payload['mensaje'],
      uid: payload['para'],
      animacion: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _mensaje.insert(0, message);
    });
    message.animacion.forward();
  }

  @override
  Widget build(BuildContext context) {
    final chatSer = chatServ;
    final usuarioDes = chatSer!.usuarioDestino;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'usuarios');
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black54,
            ),
          ),
          title: Column(
            textDirection: TextDirection.ltr,
            children: [
              Center(
                child: CircleAvatar(
                  maxRadius: 19,
                  backgroundColor: const Color.fromARGB(255, 20, 76, 122),
                  child: Text(
                    usuarioDes!.nombre.substring(0, 2),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                usuarioDes.nombre,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: _mensaje.length,
                    itemBuilder: (_, index) => _mensaje[index]),
              ),
              const Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        //color: Color.fromARGB(255, 67, 62, 61),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textCtrl,
                onSubmitted: _valorenviado,
                onChanged: (texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      estaescribiendo = true;
                    } else {
                      estaescribiendo = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(hintText: null),
                focusNode: _focusNode,
              ),
            ),
            //boton de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isAndroid
                  ? CupertinoButton(
                      onPressed: estaescribiendo
                          ? () => _valorenviado(_textCtrl.text.trim())
                          : null,
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: estaescribiendo
                              ? () => _valorenviado(_textCtrl.text.trim())
                              : null,
                          icon: const Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _valorenviado(String texto) {
    if (texto.isEmpty) return;

    _textCtrl.clear();
    _focusNode.requestFocus();

    final newMensaje = ChatMessage(
      textoCh: texto,
      uid: authServ!.usuario!.uid,
      animacion: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _mensaje.insert(0, newMensaje);
    newMensaje.animacion.forward();
    setState(() {
      estaescribiendo = false;
    });

    socketServ!.emit('mensaje-personal', {
      'emisor': authServ!.usuario!.uid,
      'para': chatServ!.usuarioDestino!.uid,
      'mensaje': texto.trim()
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _mensaje) {
      message.animacion.dispose();
    }

    socketServ!.socketG.off('mensaje-personal');

    super.dispose();
  }
}
