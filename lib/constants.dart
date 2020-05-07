import 'package:flutter/material.dart';

const BoxDecoration kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
    colors: [
      const Color(0xFF01579B),
      const Color(0x000277BD)
    ], // whitish to gray
    tileMode: TileMode.repeated, // repeats the gradient over the canvas
  ),
);
