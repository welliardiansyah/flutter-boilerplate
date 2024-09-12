import 'dart:convert';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:iam_mobile/src/routers/constant.dart';
import 'package:base32/base32.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TOTP_PERIOD_SECONDS = 25;
  static const TOTP_DIGITS = 4;

  int _duration = TOTP_PERIOD_SECONDS;
  final CountDownController _controller = CountDownController();

  String? userOtp;
  String? _userProfile;
  String? _secretKey;
  String? _accessToken;
  String? _email;

  Future<void> _generateTotp() async {
    final prefs = await SharedPreferences.getInstance();
    String? secret = prefs.getString('secretKeysOr');
    try {
      final keyBytes = base32.decode(secret!);
      final now = DateTime.now().toUtc();
      final time = now.millisecondsSinceEpoch ~/ 1000 ~/ TOTP_PERIOD_SECONDS;
      final data = Uint8List(8)..buffer.asByteData().setInt64(0, time);
      final key = Hmac(sha1, keyBytes);
      final hash = key.convert(data);
      final offset = hash.bytes[hash.bytes.length - 1] & 0xF;
      var truncatedHash = 0;

      for (var i = offset; i < offset + 4; ++i) {
        truncatedHash <<= 8;
        truncatedHash |= hash.bytes[i];
      }

      truncatedHash &= 0x7FFFFFFF;
      truncatedHash %= pow(10, TOTP_DIGITS).toInt();

      String otp = NumberFormat('0000').format(truncatedHash);

      setState(() {
        userOtp = otp;
      });

      final secondsSincePeriodStart =
          now.millisecondsSinceEpoch ~/ 1000 % TOTP_PERIOD_SECONDS;
      final remainingTime = TOTP_PERIOD_SECONDS - secondsSincePeriodStart;

      setState(() {
        _duration = remainingTime;
      });

      final expirationTime = now.add(Duration(seconds: remainingTime));
    } catch (error) {
      print('Error generating OTP: $error');
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userProfileJson = prefs.getString('userProfile');

    if (userProfileJson != null) {
      Map<String, dynamic> userProfile = jsonDecode(userProfileJson);
      String? email = userProfile['email'];

      setState(() {
        _userProfile = userProfileJson;
        _email = email;
        _accessToken = prefs.getString('accessToken');
      });
    } else {
      print('No user profile found');
    }
  }

  @override
  void initState() {
    super.initState();
    _generateTotp();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Authenticator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(scanCodeRoute, arguments: ["Add Account"]);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 18,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 21, right: 21, top: 12),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Center(child: Image.asset(logoIam)),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PLN IAM Mobile"),
                          Text(
                            _email.toString(),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      CircularCountDownTimer(
                        key: UniqueKey(),
                        duration: _duration,
                        initialDuration: 0,
                        controller: _controller,
                        width: 30,
                        height: 30,
                        ringColor: Colors.grey[300]!,
                        fillColor: primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        strokeWidth: 5.0,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                            fontSize: 12.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: true,
                        isTimerTextShown: true,
                        autoStart: true,
                        onStart: () {},
                        onComplete: () {
                          setState(() {
                            _generateTotp();
                          });
                        },
                        onChange: (String timeStamp) {},
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            return "0";
                          } else {
                            return Function.apply(
                                defaultFormatterFunction, [duration]);
                          }
                        },
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Text(
                          userOtp.toString(),
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 5,
                              fontSize: 21),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: userOtp.toString()));
                        },
                        child: Icon(
                          Icons.copy,
                          color: Colors.black54,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Get.toNamed(scanCodeRoute,
                                arguments: ["Scan QR Code"]);
                          },
                          child: SvgPicture.asset(iconScan))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 21, right: 21, top: 12),
            //   padding: EdgeInsets.all(14),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.white,
            //       border: Border.all(color: Colors.grey.shade200)),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Container(
            //             height: 40,
            //             width: 40,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: primaryColor),
            //             child: Center(
            //                 child: Text(
            //               "MI",
            //               style: TextStyle(color: Colors.white),
            //             )),
            //           ),
            //           SizedBox(
            //             width: 12,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text("Microsoft Office"),
            //               Text(
            //                 "kenzi.lawson@example.com",
            //                 style: TextStyle(color: Colors.grey),
            //               )
            //             ],
            //           ),
            //           Spacer(),
            //           InkWell(
            //               onTap: () {
            //                 Get.toNamed(accountSettingRoute);
            //               },
            //               child: SvgPicture.asset(iconSetting))
            //         ],
            //       ),
            //       SizedBox(
            //         height: 14,
            //       ),
            //       Row(
            //         children: [
            //           CircularCountDownTimer(
            //             key: UniqueKey(),
            //             duration: _duration,
            //             initialDuration: 0,
            //             controller: CountDownController(),
            //             width: 30,
            //             height: 30,
            //             ringColor: Colors.grey[300]!,
            //             ringGradient: null,
            //             fillColor: primaryColor,
            //             fillGradient: null,
            //             backgroundColor: Colors.grey.shade200,
            //             backgroundGradient: null,
            //             strokeWidth: 5.0,
            //             strokeCap: StrokeCap.round,
            //             textStyle: TextStyle(
            //                 fontSize: 12.0,
            //                 color: primaryColor,
            //                 fontWeight: FontWeight.bold),
            //             textAlign: TextAlign.center,
            //             textFormat: CountdownTextFormat.S,
            //             isReverse: true,
            //             isReverseAnimation: true,
            //             isTimerTextShown: true,
            //             autoStart: true,
            //             onStart: () {
            //               // debugPrint('Countdown Started');
            //             },
            //             onComplete: () {
            //               setState(() {});
            //               // debugPrint('Countdown Ended');
            //             },
            //             onChange: (String timeStamp) {
            //               // debugPrint('Countdown Changed $timeStamp');
            //             },
            //             timeFormatterFunction:
            //                 (defaultFormatterFunction, duration) {
            //               if (duration.inSeconds == 0) {
            //                 return "0";
            //               } else {
            //                 return Function.apply(
            //                     defaultFormatterFunction, [duration]);
            //               }
            //             },
            //           ),
            //           SizedBox(
            //             width: 24,
            //           ),
            //           Container(
            //             padding: EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: Colors.grey.shade200),
            //             child: Text(
            //               "353377",
            //               style: TextStyle(
            //                   color: primaryColor,
            //                   fontWeight: FontWeight.w400,
            //                   letterSpacing: 5,
            //                   fontSize: 21),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 24,
            //           ),
            //           InkWell(
            //             onTap: () async {
            //               await Clipboard.setData(
            //                   ClipboardData(text: "353377"));
            //             },
            //             child: Icon(
            //               Icons.copy,
            //               color: Colors.black54,
            //             ),
            //           ),
            //           // Spacer(),
            //           // Icon(Icons.qr_code_scanner)
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 3,
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 21, right: 21, top: 12),
            //   padding: EdgeInsets.all(14),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.white,
            //       border: Border.all(color: Colors.grey.shade200)),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Container(
            //             height: 40,
            //             width: 40,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: Colors.white),
            //             child: Center(child: Image.asset(logoAms)),
            //           ),
            //           SizedBox(
            //             width: 12,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text("PLN AMS Korporat"),
            //               Text(
            //                 "felicia.reid@example.com",
            //                 style: TextStyle(color: Colors.grey),
            //               )
            //             ],
            //           ),
            //           Spacer(),
            //           InkWell(
            //               onTap: () {
            //                 Get.toNamed(accountSettingRoute);
            //               },
            //               child: SvgPicture.asset(iconSetting))
            //         ],
            //       ),
            //       SizedBox(
            //         height: 14,
            //       ),
            //       Row(
            //         children: [
            //           CircularCountDownTimer(
            //             key: UniqueKey(),
            //             duration: _duration,
            //             initialDuration: 0,
            //             controller: CountDownController(),
            //             width: 30,
            //             height: 30,
            //             ringColor: Colors.grey[300]!,
            //             ringGradient: null,
            //             fillColor: primaryColor,
            //             fillGradient: null,
            //             backgroundColor: Colors.grey.shade200,
            //             backgroundGradient: null,
            //             strokeWidth: 5.0,
            //             strokeCap: StrokeCap.round,
            //             textStyle: TextStyle(
            //                 fontSize: 12.0,
            //                 color: primaryColor,
            //                 fontWeight: FontWeight.bold),
            //             textAlign: TextAlign.center,
            //             textFormat: CountdownTextFormat.S,
            //             isReverse: true,
            //             isReverseAnimation: true,
            //             isTimerTextShown: true,
            //             autoStart: true,
            //             onStart: () {
            //               // debugPrint('Countdown Started');
            //             },
            //             onComplete: () {
            //               setState(() {});
            //               // debugPrint('Countdown Ended');
            //             },
            //             onChange: (String timeStamp) {
            //               // debugPrint('Countdown Changed $timeStamp');
            //             },
            //             timeFormatterFunction:
            //                 (defaultFormatterFunction, duration) {
            //               if (duration.inSeconds == 0) {
            //                 return "0";
            //               } else {
            //                 return Function.apply(
            //                     defaultFormatterFunction, [duration]);
            //               }
            //             },
            //           ),
            //           SizedBox(
            //             width: 24,
            //           ),
            //           Container(
            //             padding: EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: Colors.grey.shade200),
            //             child: Text(
            //               "355353",
            //               style: TextStyle(
            //                   color: primaryColor,
            //                   fontWeight: FontWeight.w400,
            //                   letterSpacing: 5,
            //                   fontSize: 21),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 24,
            //           ),
            //           InkWell(
            //             onTap: () async {
            //               await Clipboard.setData(
            //                   ClipboardData(text: "355353"));
            //             },
            //             child: Icon(
            //               Icons.copy,
            //               color: Colors.black54,
            //             ),
            //           ),
            //           // Spacer(),
            //           // Icon(Icons.qr_code_scanner)
            //         ],
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
