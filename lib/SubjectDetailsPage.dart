import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectDetailsPage extends StatefulWidget {
  final String studentName;
  final String subjectName;

  const SubjectDetailsPage({
    super.key,
    required this.studentName,
    required this.subjectName,
  });

  @override
  State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
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
      final userSnapshot = await firestore
          .collection('users')
          .where('username', isEqualTo: widget.studentName)
          .get();

      if (userSnapshot.docs.isEmpty) {
        print("User not found");
        return;
      }

      final userId = userSnapshot.docs.first.id;

      final attendanceSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection(widget.subjectName)
          .get();

      List<Map<String, dynamic>> loadedData = attendanceSnapshot.docs.map((doc) {
        final data = doc.data();
        final id = doc.id;
        final match = RegExp(r'\d+').firstMatch(id);
        final number = match != null ? int.parse(match.group(0)!) : 0;

        return {
          'pertemuan': number,
          'status': data['status'] ?? false,
        };
      }).toList();

      loadedData.sort((a, b) => a['pertemuan'].compareTo(b['pertemuan']));

      setState(() {
        pertemuan = loadedData;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching pertemuan data: $e");
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
        title: widget.subjectName,
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
    super.key,
    required this.title,
    this.height = 60,
    this.widthFactor = 1.0,
  });

  @override
  Size get preferredSize => Size.fromHeight(
      height + MediaQueryData.fromView(WidgetsBinding.instance.window).padding.top);

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
