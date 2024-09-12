import 'package:get/get.dart';
import 'package:iam_mobile/src/pages/home/account_setting.dart';
import 'package:iam_mobile/src/pages/home/scan_code.dart';
import 'package:iam_mobile/src/pages/login/index.dart';
import 'package:iam_mobile/src/pages/login/permission_location.dart';
import 'package:iam_mobile/src/pages/main_page.dart';
import 'package:iam_mobile/src/pages/privacy/index.dart';
import 'package:iam_mobile/src/pages/profile/email/index.dart';
import 'package:iam_mobile/src/pages/profile/profile/index.dart';
import 'package:iam_mobile/src/pages/splash.dart';

import 'constant.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: rootRoute,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: loginRoute,
    page: () => const Login(),
  ),
  GetPage(
    name: mainRoute,
    page: () => const MainPage(),
  ),
  GetPage(
    name: editprofileRoute,
    page: () => const ProfilEdit(),
  ),
  GetPage(
    name: emailprofileRoute,
    page: () => const EmailProfile(),
  ),
  GetPage(
    name: permissionRoute,
    page: () => const PermissionLocation(),
  ),
  GetPage(
    name: accountSettingRoute,
    page: () => const AccountSetting(),
  ),
  GetPage(
    name: scanCodeRoute,
    page: () => const ScanCode(),
  ),
  GetPage(
    name: privacyRoute,
    page: () => const Privacy(),
  ),
];