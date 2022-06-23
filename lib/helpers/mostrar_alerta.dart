import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

mostrarAlerta(
    BuildContext context, String titulo, String mensaje, Color color) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      color: color,
      title: titulo,
      message: mensaje,
      contentType: ContentType.failure,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
