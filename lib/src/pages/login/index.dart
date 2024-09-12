import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:iam_mobile/src/routers/constant.dart';
import 'package:iam_mobile/src/service/authService.dart';
import 'package:local_auth/local_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validate = false;
  bool inHiddenPass = true;
  bool _isHidden = true;
  bool _isLoading = false;
  final Authservice _authService = Authservice();

  void getUserLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (!(await Geolocator.isLocationServiceEnabled())) {
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {});
      print(
          "the latitude is: ${position.latitude} and th longitude is: ${position.longitude} ");
    }
  }

  @override
  void initState() {
    getUserLocation();
    _localAuthentication.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    super.initState();
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await _localAuthentication.authenticate(
        localizedReason: 'Please unlock to process',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        Get.offAllNamed(mainRoute);
      } else {
        print("error");
      }
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    await _authService.login(
      username: username.text,
      password: password.text,
      onSuccess: () {
        Get.offAllNamed(mainRoute);
      },
      onError: (message) {
        Get.rawSnackbar(message: message, backgroundColor: Colors.red);
      },
      onFinally: () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Image.asset(
                    logoIamLogin,
                    scale: 1.5,
                  ),
                  SizedBox(height: 45),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                        label: const Text('Username'),
                        floatingLabelStyle: const TextStyle(fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: TextField(
                      controller: password,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        floatingLabelStyle: const TextStyle(fontSize: 18),
                        suffixIcon: InkWell(
                          onTap: togglebutton,
                          child: Icon(
                            _isHidden ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        height: 56,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: _login,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 56,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: _authenticateWithBiometrics,
                            child: Icon(
                              Icons.fingerprint,
                              size: 40,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Dengan login, Anda sudah mengetahui dan menyetujui"),
                  InkWell(
                      onTap: () {
                        Get.toNamed(privacyRoute);
                      },
                      child: Text(
                        "Syarat & Ketentuan IAM Mobile",
                        style: TextStyle(color: primaryColor),
                      ))
                ],
              ),
            ),
          ),
          // Fullscreen loading indicator
          if (_isLoading)
            Container(
              color: Colors.black54, // Background color to dim the screen
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void togglebutton() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
