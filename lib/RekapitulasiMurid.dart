import 'package:flutter/material.dart';

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
    );
  }
}

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
  Size get preferredSize =>
      Size.fromHeight(height + MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarWidth = screenWidth * widthFactor;

    return SafeArea(
      child: Container(
        width: appBarWidth,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: Color(0xFF4D6FCE),
          borderRadius: BorderRadius.only(
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
