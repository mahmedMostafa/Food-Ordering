import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String BASE_URL = "recipesapi.herokuapp.com";

const whiteTextColor = Color(0xFFF9F4F5);

final r = Random();

double doubleInRange(num start, num end) =>
    r.nextDouble() * (end - start) + start;

int numberInRange(int min, int max) => min + r.nextInt(max - min);

formDecoration(String hint) => InputDecoration(
  focusColor: whiteTextColor,
  labelText: hint,
  labelStyle: TextStyle(color: whiteTextColor.withOpacity(.8)),
  hintStyle: TextStyle(color: Colors.white),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);
