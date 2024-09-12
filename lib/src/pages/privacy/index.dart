import 'package:flutter/material.dart';
class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Syarat dan Ketentuan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Syarat dan Ketentuan IAM Mobile",style: TextStyle(fontWeight: FontWeight.w700),)
          ],
        ),
      ),
    );
  }
}
