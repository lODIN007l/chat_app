import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData ico;
  final String placeholder;
  final TextEditingController textcontrolador;
  final TextInputType keybTipo;
  final bool isPassword;

  const CustomInput({
    required this.ico,
    required this.placeholder,
    required this.textcontrolador,
    this.keybTipo = TextInputType.text,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        //anexamos el controlador
        controller: textcontrolador,
        autocorrect: false,
        keyboardType: keybTipo,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(ico),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder),
      ),
    );
  }
}
