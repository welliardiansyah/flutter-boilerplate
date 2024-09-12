import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iam_mobile/src/config/assets.dart';
import 'package:iam_mobile/src/config/theme.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool _isExpanded = true;
  bool _isExpanded2 = false;
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Log Activity',
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 320,
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'You should recognise each of these recent activities. If one looks unfamiliar, you should review your ',
                            ),
                            TextSpan(
                              text: 'security info',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Security info clicked!');
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Agustus 2024',
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade800),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //change to listview.builder
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xffEDEFF5))),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Color(0xffEDEFF5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 12, bottom: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'Today at 11:28:23 AM WIB',
                                      style: GoogleFonts.inter(),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      _isExpanded
                                          ? Icons.keyboard_arrow_down_outlined
                                          : Icons.keyboard_arrow_right_rounded,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (_isExpanded) ...[
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffEDEFF5)),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Image.asset(logoAms),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PLN AMS Korporat',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'felicia.reid@example.copm',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Device :',
                                    style: GoogleFonts.inter(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phonelink_rounded,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Chrome 74 on MacOs 202.57.31.154',
                                        style: GoogleFonts.inter(
                                            fontSize: 12.8,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                color: greyColor,
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location :',
                                    style: GoogleFonts.inter(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.pin_drop_outlined,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Jakarta Raya, Indonesia',
                                        style: GoogleFonts.inter(
                                            fontSize: 12.8,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                color: greyColor,
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status :',
                                        style: GoogleFonts.inter(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            successIcon,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Successful sign-in',
                                            style: GoogleFonts.inter(
                                                fontSize: 12.8,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Not You?',
                                        style: GoogleFonts.inter(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            warningIcon,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Secure your account',
                                            style: GoogleFonts.inter(
                                              fontSize: 12.8,
                                              color: Colors.blueAccent,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
              
                  // Second Log
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xffEDEFF5))),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isExpanded2 = !_isExpanded2;
                              });
                            },
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Color(0xffEDEFF5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 12, bottom: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'Today at 11:28:23 AM WIB',
                                      style: GoogleFonts.inter(),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      _isExpanded2
                                          ? Icons.keyboard_arrow_down_outlined
                                          : Icons.keyboard_arrow_right_rounded,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (_isExpanded2) ...[
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffEDEFF5)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text('PLN'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'FortiGate CAPPO SAML Mampang',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'felicia.reid@example.copm',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Device :',
                                    style: GoogleFonts.inter(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_android_rounded,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Chrome 74 on MacOs 202.57.31.154',
                                        style: GoogleFonts.inter(
                                            fontSize: 12.8,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                color: greyColor,
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location :',
                                    style: GoogleFonts.inter(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.pin_drop_outlined,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Jakarta Raya, Indonesia',
                                        style: GoogleFonts.inter(
                                            fontSize: 12.8,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                color: greyColor,
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status :',
                                        style: GoogleFonts.inter(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            failedIcon,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Failed sign-in',
                                            style: GoogleFonts.inter(
                                                fontSize: 12.8,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Not You?',
                                        style: GoogleFonts.inter(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            warningIcon,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Secure your account',
                                            style: GoogleFonts.inter(
                                              fontSize: 12.8,
                                              color: Colors.blueAccent,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ]
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
