import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/routers/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    Timer(const Duration(seconds: 3), () {
      Get.offAndToNamed(loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff02657B), Color(0xff59D9FA)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Image.asset(splash),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Powered by:",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "PLN Icon Plus",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
