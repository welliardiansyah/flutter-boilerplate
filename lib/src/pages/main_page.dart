import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:iam_mobile/src/pages/activity/index.dart';
import 'package:iam_mobile/src/pages/home/index.dart';
import 'package:iam_mobile/src/pages/profile/index.dart';
import 'package:local_auth/local_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  String _status = 'App is running';
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  DateTime? currentBackPressTime;

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
        setState(() {
          _isAuthenticating = false;
          _authorized = 'Authenticating';
        });
        // Get.offAllNamed(mainRoute);
      } else {
        print("error");
      }
      // setState(() {
      //   _isAuthenticating = false;
      //   _authorized = 'Authenticating';
      // });
    } on PlatformException catch (e) {
      print(e);
      // setState(() {
      //   _isAuthenticating = false;
      //   _authorized = 'Error - ${e.message}';
      // });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  final List<Widget> _pages = <Widget>[
    Home(
      key: const PageStorageKey<String>('Authenticator'),
    ),
    Activity(
      key: const PageStorageKey<String>('Log Activity'),
    ),
    Profile(
      key: const PageStorageKey<String>('profile'),
    ),
  ];

  Widget _bottomNavigationBar(int selectedIndex) => Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          onTap: (int index) => setState(() => _selectedIndex = index),
          currentIndex: selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home_sharp), label: 'Authenticator'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Log Activity'),

            // BottomNavigationBarItem(
            //     icon: Icon(Icons.add_shopping_cart), label: 'Order'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.add_chart), label: 'Stock'),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'profile'),
          ],
        ),
      );

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.rawSnackbar(message: "Tekan sekali lagi untuk keluar");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          _status = 'App is resume';
          break;
        case AppLifecycleState.paused:
          _status = 'paused';
          _authenticateWithBiometrics();
          break;
        case AppLifecycleState.inactive:
          _status = 'App is inactive';
          break;
        case AppLifecycleState.detached:
          _status = 'App is detached';
          break;
        case AppLifecycleState.hidden:
        // TODO: Handle this case.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //     onWillPop: _onWillPop,
    //     child:
    return Scaffold(
      bottomNavigationBar: _isAuthenticating ? Container() : _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: Stack(
          children: [
            _pages[_selectedIndex],
            _isAuthenticating ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(logoIamLogin,scale: 1.5,),
                  SizedBox(height: 12,),
                  Text("IAM Mobile locked",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      _authenticateWithBiometrics();
                    },
                      child: Text("Unlock",style: TextStyle(fontWeight: FontWeight.w700),)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
                ],
              ),
            ) : Container()
          ],
        ),
        bucket: bucket,
      ),
    );
    // );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
