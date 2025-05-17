import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QRCodePage(),
    );
  }
}

class QRCodePage extends StatelessWidget {
  const QRCodePage({super.key});

  final String qrData = 'https://yourdata.com';
  
  @override
  Widget build(BuildContext context) {
    final String qrApiUrl = 'https://api.qrserver.com/v1/create-qr-code/?data=$qrData&size=200x200';

    return Scaffold(
      appBar: AppBar(title: const Text('QR Code API Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(qrApiUrl),
            const SizedBox(height: 20),
            Text('QR for: $qrData'),
          ],
        ),
      ),
    );
  }
}
