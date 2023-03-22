import 'package:flutter/material.dart';

class Sizes {
  static double _width = 1080;
  static double _height = 1920;
  static double _aspectRatio = _height / _width;
  static double _topPadding = 60;
  static double _bottomPadding = 100;

  static void setSizes(BuildContext context) {
    _topPadding = MediaQuery.of(context).padding.top;
    _height =
        MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _aspectRatio = _height / _width;
    _topPadding = MediaQuery.of(context).padding.top;
    _bottomPadding = (_height / 14) + (_height / 36);
  }

  static double getWidth() {
    return _width;
  }

  static double getHeight() {
    return _height;
  }

  static double getAspectRatio() {
    return _aspectRatio;
  }

  static double getTopPadding() {
    return _topPadding;
  }

  static double getBottomPadding() {
    return _bottomPadding;
  }

}
