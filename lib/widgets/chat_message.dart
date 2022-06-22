import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String textoCh;
  final String uid;
  final AnimationController animacion;

  const ChatMessage(
      {required this.textoCh, required this.uid, required this.animacion});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animacion,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animacion, curve: Curves.easeOut),
        child: Container(
          child: this.uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          this.textoCh,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          left: 5,
          right: 50,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          this.textoCh,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
