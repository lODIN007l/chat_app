import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  final String titulo1;

  const LogoApp({required this.titulo1});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            Text(
              titulo1,
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
