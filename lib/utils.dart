import 'dart:math';
import 'package:flutter/material.dart';

int calculateMaxVisibleImages(BuildContext context, {
  double imageWidth = 60.0,
  double imageSpacing = 8.0,
  double sidePadding = 16.0,
  double buttonWidth = 48.0,
  int buttonCount = 3,
}) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double availableWidth = screenWidth - sidePadding - (buttonWidth * buttonCount);
  int maxImages = (availableWidth / (imageWidth + imageSpacing)).ceil();
  return max(1, maxImages);
}
