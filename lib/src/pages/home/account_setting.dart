import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    name.text = "Microsoft Office";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 21, right: 21, top: 12),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Microsoft Office"),
                        Text(
                          "kenzi.lawson@example.com",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text(
                                'Rename',
                                style: TextStyle(color: primaryColor),
                              ),
                              content: Container(
                                height: 50,
                                // margin: EdgeInsets.only(left: 24,right: 24),
                                child: TextField(
                                  controller: name,
                                  decoration: InputDecoration(
                                    label: const Text('Account Name'),
                                    floatingLabelStyle: const TextStyle(fontSize: 18),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade300)),
                                  ),
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        height: 40,
                                        width: 100.sp,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey, // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          onPressed: () async {},
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                        height: 40,
                                        width: 100.sp,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor, // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          onPressed: () async {},
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Icon(
                          CupertinoIcons.pencil,
                          color: Colors.grey,
                        ))
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Center(
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () async {
                          Get.dialog(
                            AlertDialog(
                              // title: const Text('Rename',style: TextStyle(color: primaryColor),),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(icDelete),
                                  Center(
                                      child: Text(
                                    "Are you sure you want to delete your account?",
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 40,
                                        width: 100.sp,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey, // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Get.back();
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                        height: 40,
                                        width: 100.sp,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor, // Background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          onPressed: () async {},
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Remove Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
