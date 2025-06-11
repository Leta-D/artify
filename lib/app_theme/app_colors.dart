import 'package:flutter/material.dart';

Color appWhite(double opacity) => Color.fromRGBO(255, 255, 255, opacity);
Color appGrey(double opacity) => Color.fromRGBO(99, 99, 102, opacity);
Color appBlack(double opacity) => Color.fromRGBO(16, 16, 16, opacity);

Color appRed(double opaciy) => Color.fromRGBO(204, 15, 72, opaciy);

Color appProgressIndicator(double opacity) =>
    Color.fromRGBO(252, 3, 152, opacity);

Gradient buttonGradient = LinearGradient(
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  colors: [
    const Color.fromARGB(255, 3, 66, 238),
    const Color.fromARGB(255, 163, 36, 185),
    const Color.fromARGB(255, 238, 22, 94),
    const Color.fromARGB(255, 240, 39, 4),
  ],
  stops: [0.1, 0.5, 0.7, 1.0],
);
