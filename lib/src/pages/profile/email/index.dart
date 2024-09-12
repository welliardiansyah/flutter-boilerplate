import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/theme.dart';

class EmailProfile extends StatefulWidget {
  const EmailProfile({super.key});

  @override
  State<EmailProfile> createState() => _EmailProfileState();
}

class _EmailProfileState extends State<EmailProfile> {
  final TextEditingController _email =
      TextEditingController(text: 'michael.gtr@example.com');
  final TextEditingController _phone =
      TextEditingController(text: '0085 3532 432');

  bool _showSecondEmailField = false;
  bool _showSecondPhoneField = false;
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Email & Phone',
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text(
                'Email',
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _showSecondEmailField
                  ? SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          label: const Text('Secondary Email'),
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
                    )
                  : SizedBox(
                      height: 56,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _showSecondEmailField = true;
                            });
                          },
                          child: Text(
                            'Add 2nd Email',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Phone',
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _phone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _showSecondPhoneField
                  ? SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          label: const Text('Secondary Phone'),
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
                    )
                  : SizedBox(
                      height: 56,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _showSecondEmailField = true;
                            });
                          },
                          child: Text(
                            'Add 2nd Phone',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
