import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getShowLoadingIndicator() async {
  print('showLoadingIndicator start');
  await Get.dialog(
    Center(
      child: GetPlatform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),
    ),
    barrierDismissible: false,
  );
}

getHideLoadingIndicator() {
  print('hideLoadingIndicator start');
  Get.back();
  print('hideLoadingIndicator end');
}
