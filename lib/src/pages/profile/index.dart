import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routers/constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _email;

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userProfileJson = prefs.getString('userProfile');

    if (userProfileJson != null) {
      Map<String, dynamic> userProfile = jsonDecode(userProfileJson);
      String? email = userProfile['email'];

      setState(() {
        _email = email;
      });
    } else {
      print('No user profile found');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey.shade300),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.person,
                          // color: background,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PT PLN Icon Plus',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(fontSize: 20)),
                        ),
                        Text(
                          _email.toString(),
                          style: GoogleFonts.inter(
                              textStyle:
                                  TextStyle(color: Colors.grey.shade600)),
                        )
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.settings_outlined,
                      color: primaryColor,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.grey.shade300,
              height: 1,
            ),
            InkWell(
              onTap: () => Get.toNamed(editprofileRoute),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        profileIcon,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile',
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              color: Colors.grey.shade300,
              height: 1,
            ),
            InkWell(
              onTap: () => Get.toNamed(emailprofileRoute),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        emailIcon,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Email, Phone',
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              color: Colors.grey.shade300,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  children: [
                    Image.asset(
                      notificationIcon,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Notification',
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              color: Colors.grey.shade300,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  children: [
                    Image.asset(
                      passwordIcon,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Change Password',
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              color: Colors.grey.shade300,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  children: [
                    Image.asset(
                      employeeIcon,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Employee',
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              color: Colors.grey.shade300,
              height: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF2F3F8), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Logout',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
