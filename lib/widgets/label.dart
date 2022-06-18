import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String ruta;
  final String text1;
  final String text2;

  const LabelWidget(
      {required this.ruta, required this.text1, required this.text2});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            text1,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(
              text2,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
