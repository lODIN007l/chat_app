import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text1;
  final VoidCallback onpress1;

  CustomButton({required this.text1, required this.onpress1});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(2),
          shape: MaterialStateProperty.all(StadiumBorder())),
      // elevation: 2,
      // highlightElevation: 5,
      // color: Colors.blue,
      // shape: StadiumBorder(),
      onPressed: () => this.onpress1(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text1,
              style: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
