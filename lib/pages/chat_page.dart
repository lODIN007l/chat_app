import 'dart:io';

import 'package:aoo_chat_live/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textCtrl = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _mensaje = [];

  bool estaescribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            textDirection: TextDirection.ltr,
            children: [
              Center(
                child: CircleAvatar(
                  maxRadius: 14,
                  backgroundColor: Colors.blue[100],
                  child: const Text(
                    'TE',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Melissa Flores ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 10,
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
                      child: const Text('Enviar'),
                      onPressed: estaescribiendo
                          ? () => _valorenviado(_textCtrl.text.trim())
                          : null,
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
    print(texto);
    _textCtrl.clear();
    _focusNode.requestFocus();

    final newMensaje = new ChatMessage(
      textoCh: texto,
      uid: '456',
      animacion: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _mensaje.insert(0, newMensaje);
    newMensaje.animacion.forward();
    setState(() {
      estaescribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO: off del socket

    for (ChatMessage message in _mensaje) {
      message.animacion.dispose();
    }
    super.dispose();
  }
}
