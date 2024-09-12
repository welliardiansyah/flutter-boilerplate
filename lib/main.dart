import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:iam_mobile/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // implemented using window manager
  await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}
