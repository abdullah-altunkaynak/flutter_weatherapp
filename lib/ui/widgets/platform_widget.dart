import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    Key? key,
    required this.androidBuilder,
    required this.iosBuilder,
    required this.webBuilder,
  }) : super(key: key);

  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;
  final WidgetBuilder webBuilder;

  @override
  Widget build(context) {
    if (GetPlatform.isWeb) {
      return webBuilder(context);
    } else if (GetPlatform.isAndroid) {
      return androidBuilder(context);
    } else if (GetPlatform.isIOS) {
      return iosBuilder(context);
    } else {
      return androidBuilder(context);
    }
  }
}
