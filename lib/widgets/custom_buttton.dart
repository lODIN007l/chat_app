import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text1;
  final VoidCallback onpress1;

  CustomButton({required this.text1, required this.onpress1});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onpress1,
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: const StadiumBorder(),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
