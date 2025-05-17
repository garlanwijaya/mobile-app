import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SubjectGenerateQR.dart';

Widget buildSubjectButton(BuildContext context, String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectGenerateQR(subjectName: title),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

class BerandaGuru extends StatelessWidget {
  const BerandaGuru({super.key});

  // ✅ Fungsi untuk tambah dummy data ke Firestore
  Future<void> addDummyData(BuildContext context) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.add({
        'name': 'Garland Guru',
        'role': 'teacher',
        'email': 'garland@example.com',
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Dummy data berhasil ditambahkan ke Firestore')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Gagal menambahkan data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF4D6FCE),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: Text(
                      "Selamat Datang,\nGarland!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink,
                    child: Text("😡", style: TextStyle(fontSize: 28)),
                  ),
                ],
              ),
            ),

            // List Mata Pelajaran dan Tombol Test
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    buildSubjectButton(context, "Matematika"),
                    buildSubjectButton(context, "Fisika"),
                    buildSubjectButton(context, "Kimia"),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
