import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RekapitulasiMurid extends StatefulWidget {
  final String name;
  final String selectedSubject;

  const RekapitulasiMurid({
    Key? key,
    required this.name,
    required this.selectedSubject,
  }) : super(key: key);

  @override
  State<RekapitulasiMurid> createState() => _RekapitulasiMuridState();
}

class _RekapitulasiMuridState extends State<RekapitulasiMurid> {
  List<Map<String, dynamic>> pertemuan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPertemuanData();
  }

  Future<void> fetchPertemuanData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Cari user ID berdasarkan username
      final userSnapshot = await firestore
          .collection('users')
          .where('username', isEqualTo: widget.name)
          .get();

      if (userSnapshot.docs.isEmpty) {
        print("User not found");
        return;
      }

      final userId = userSnapshot.docs.first.id;

      // Ambil data kehadiran dari subkoleksi mata pelajaran
      final attendanceSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection(widget.selectedSubject)
          .get();

      List<Map<String, dynamic>> loadedData = attendanceSnapshot.docs.map((doc) {
        final data = doc.data();
        final id = doc.id;
        final match = RegExp(r'\d+').firstMatch(id); // Ekstrak angka dari nama dokumen
        final number = match != null ? int.parse(match.group(0)!) : 0;

        return {
          'pertemuan': number,
          'status': data['status'] ?? false,
        };
      }).toList();

      // Urutkan berdasarkan nomor pertemuan
      loadedData.sort((a, b) => a['pertemuan'].compareTo(b['pertemuan']));

      setState(() {
        pertemuan = loadedData;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching pertemuan data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Rekapitulasi - ${widget.name}",
        height: 60,
        widthFactor: 0.95,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : pertemuan.isEmpty
                ? const Center(child: Text("Tidak ada data pertemuan."))
                : ListView.builder(
                    itemCount: pertemuan.length,
                    itemBuilder: (context, index) {
                      final data = pertemuan[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Pertemuan ${data['pertemuan']}',
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
  Size get preferredSize => Size.fromHeight(
      height + MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top);

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
