import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Custom AppBar dengan tombol kembali
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final double widthFactor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.height = 60,
    this.widthFactor = 1.0,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarWidth = screenWidth * widthFactor;

    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: height,
          width: appBarWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF4D6FCE),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman utama dengan QR
class SubjectGenerateQR extends StatefulWidget {
  final String subjectName;

  const SubjectGenerateQR({super.key, required this.subjectName});

  @override
  State<SubjectGenerateQR> createState() => _SubjectGenerateQRState();
}

class _SubjectGenerateQRState extends State<SubjectGenerateQR> {
  int pertemuan = 1;
  int durasi = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: CustomAppBar(
        title: widget.subjectName,
        height: 60,
        widthFactor: 1.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Pertemuan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pertemuan :", style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (pertemuan > 1) pertemuan--;
                              });
                            },
                            icon: const Icon(Icons.arrow_left),
                          ),
                          Text(
                            "$pertemuan",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                pertemuan++;
                              });
                            },
                            icon: const Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Durasi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Durasi :", style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (durasi > 5) durasi -= 5;
                              });
                            },
                            icon: const Icon(Icons.arrow_left),
                          ),
                          Text(
                            "$durasi Menit",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                durasi += 5;
                              });
                            },
                            icon: const Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Tombol Generate QR
                  ElevatedButton(
                    onPressed: () {
                      final qrData = jsonEncode({
                        "subject": widget.subjectName,
                        "meeting": pertemuan,
                        "duration": durasi,
                        "timestamp": DateTime.now().toIso8601String(),
                      });

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => QRPreviewPage(qrData: qrData),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text(
                        'Generate QR',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman preview QR code
class QRPreviewPage extends StatelessWidget {
  final String qrData;

  const QRPreviewPage({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Absensi")),
      body: Center(
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 300.0,
        ),
      ),
    );
  }
}
