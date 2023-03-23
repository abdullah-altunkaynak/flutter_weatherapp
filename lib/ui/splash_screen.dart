import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () async {
      Get.offAllNamed('/weather-main-screen');
    });
    return Material(
      child: Container(
        child: Scaffold(
            body: Container(
          width: Sizes.getWidth(),
          height: Sizes.getHeight(),
          child: 
            Lottie.network(
                'https://assets5.lottiefiles.com/private_files/lf30_jmgekfqg.json'),
        )),
      ),
    );
  }
}
