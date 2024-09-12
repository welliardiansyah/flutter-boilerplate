import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ScanCode extends StatefulWidget {
  const ScanCode({super.key});

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('ws://192.168.1.6:8087'));
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  int counter = 0;
  var status = Get.arguments[0];

  @override
  void initState() {
    super.initState();
    channel.stream.listen(
      (message) {
        try {
          final jsonResponse = jsonDecode(message);

          if (jsonResponse is Map) {
            final type = jsonResponse['type'];
            final success = jsonResponse['success'];

            print('Received type: $type');
            print('Received success: $success');

            if (type == 'authenticated') {
              _showDialog(
                context: context,
                title: 'Authentication Status',
                message: success == true
                    ? 'Authentication successful!'
                    : 'Authentication failed.',
              );
            }
          } else {
            print('Unexpected JSON format: $jsonResponse');
          }
        } catch (e) {
          print('Error decoding JSON message: $e');
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket closed');
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Center(
            child: (barcode != null)
                ? Text(
                    'Barcode Type: ${barcode!.format}   Data: ${barcode!.code}')
                : Text('Scan a code'),
          )
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: primaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });

    controller.scannedDataStream.listen((barcode) async {
      print('BARCODE ${barcode.code}');
      try {
        counter++;
        await controller.pauseCamera();
        Get.back(result: barcode.code);
        String? url = barcode.code;

        if (url != null) {
          channel.sink
              .add('{"type": "scan_qr", "token": "$url", "userid": "darma"}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    });
  }

  void _showDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
