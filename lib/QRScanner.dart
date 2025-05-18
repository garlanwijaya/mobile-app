import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScannerPage extends StatefulWidget {
  final String username;

  const QRScannerPage({Key? key, required this.username}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController controller = MobileScannerController();
  bool isProcessing = false;

  void handleDetection(BarcodeCapture capture) async {
    if (isProcessing) return;

    final Barcode? barcode = capture.barcodes.first;
    final String? code = barcode?.rawValue;
    if (code == null) return;

    isProcessing = true;

    try {
      final data = jsonDecode(code);
      final subject = data['subject'];
      final meeting = "schedule_${data['meeting']}";
      print(subject);
      print(meeting);
      print(widget.username);

      if (subject == null || meeting == null) {
        throw FormatException("QR tidak valid !!");
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.username)
          .collection(subject)
          .doc(meeting)
          .set({
        'status': true,
        'created_at': DateTime.now(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil absen di $subject - Pertemuan ${data['meeting']}")),
      );
      // Navigator.pop(context);
    } catch (e) {
      print(e);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("QR tidak valid @@")),
      );
      await Future.delayed(const Duration(seconds: 2));
      isProcessing = false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Absensi"),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: handleDetection,
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}