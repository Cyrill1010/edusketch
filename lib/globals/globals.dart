import 'package:flutter/material.dart';

bool isGrade(int n) {
  return 1 <= n && n <= 6;
}

bool isPercent(int n) {
  return 0 <= n && n <= 100;
}

bool isGoalReached(int goal, int average) {
  return goal >= average;
}

bool isLightColor(int color, int limit) {
  return Color(color).red >= limit || Color(color).green >= limit || Color(color).blue >= limit;
}

int getOppositeColorComponent(int i, int limit) {
  return i > limit ? i - 2 * (i - limit) : i + 2 * (limit - i);
}

Color getOppositeColor(int color) {
  int red = getOppositeColorComponent(Color(color).red, 128);
  int green = getOppositeColorComponent(Color(color).green, 128);
  int blue = getOppositeColorComponent(Color(color).blue, 128);
  return Color.fromARGB(255, red, green, blue);
}
