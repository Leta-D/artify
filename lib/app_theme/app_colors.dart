import 'package:flutter/material.dart';

Color appWhite(double opacity) => Color.fromRGBO(255, 255, 255, opacity);
Color appGrey(double opacity) => Color.fromRGBO(99, 99, 102, opacity);
Color appBlack(double opacity) => Color.fromRGBO(16, 16, 16, opacity);

Gradient buttonGradient = LinearGradient(
  colors: [
    Color.fromRGBO(2, 58, 243, 1),
    Color.fromRGBO(2, 58, 243, 0.6),
    Color.fromRGBO(2, 58, 243, 0.5),
    Color.fromRGBO(243, 2, 211, 0.397),
    Color.fromRGBO(243, 4, 4, 0.5),
    Color.fromRGBO(243, 4, 4, 0.6),
    Color.fromRGBO(243, 4, 4, 1),
  ],
);
