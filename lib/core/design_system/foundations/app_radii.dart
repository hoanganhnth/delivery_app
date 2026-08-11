import 'package:flutter/material.dart';

abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  static const BorderRadius card = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius control = BorderRadius.all(Radius.circular(md));
  static const BorderRadius dialog = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius pillRadius = BorderRadius.all(
    Radius.circular(pill),
  );
}
