import 'package:flutter/material.dart';
import 'navbarGuru.dart';

class RekapitulasiMurid extends StatelessWidget {
  final String name;

  const RekapitulasiMurid({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Data dummy rekapitulasi
    final List<Map<String, dynamic>> pertemuan = [
      {'pertemuan': 'Pertemuan 1', 'status': true},
      {'pertemuan': 'Pertemuan 2', 'status': true},
      {'pertemuan': 'Pertemuan 3', 'status': false},
      {'pertemuan': 'Pertemuan 4', 'status': true},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Rekapitulasi - $name",
        height: 60,
        widthFactor: 0.95,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: pertemuan.length,
                itemBuilder: (context, index) {
                  final data = pertemuan[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          data['pertemuan'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              data['status'] ? Colors.green : Colors.red,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                        height: 0,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navbarGuru(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/berandaGuru');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/rekapGuru');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profileGuru');
          }
        },
      ),
    );
  }
}

// Tambahkan AppBar kustom seperti di SubjectDetailsPage
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

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: height,
        width: appBarWidth,
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: SafeArea(
          bottom: false,
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
                    fontSize: 24,
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
