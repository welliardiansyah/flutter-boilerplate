import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:iam_mobile/src/routers/constant.dart';
class PermissionLocation extends StatefulWidget {
  const PermissionLocation({super.key});

  @override
  State<PermissionLocation> createState() => _PermissionLocationState();
}

class _PermissionLocationState extends State<PermissionLocation> {
  void getUserLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (!(await Geolocator.isLocationServiceEnabled())) {
      // activegps = false;
    } else {
      // activegps = true;
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        // initPosition = LatLng(position.latitude, position.longitude);
      });
      print("the latitude is: ${position.latitude} and th longitude is: ${position.longitude} ");
      // _addMarker(_initialposition,placemark[0].name??"");
    }
  }

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SvgPicture.asset(iconLocation),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("Enable Location"),
          ),
          Image.asset(locationImage),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",textAlign:TextAlign.center,style: TextStyle(),)),
          ),
          SizedBox(height: 60,),
          Center(
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () async {
                    Get.offAllNamed(loginRoute);
                  },
                  child: Text("Ok, I understand",style: TextStyle(color: Colors.white),),)
            ),
          ),
        ],
      ),
    );
  }
}
