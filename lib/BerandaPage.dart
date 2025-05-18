import 'package:flutter/material.dart';
import 'SubjectDetailsPage.dart';
import 'meeting.dart';

Widget buildSubjectButton(BuildContext context, String title) {
  final meetings = generateMockMeetings();

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailsPage(
              subjectName: title,
              meetings: meetings,
            ),
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

// Fungsi untuk menghasilkan data pertemuan
List<Meeting> generateMockMeetings() {
  return List.generate(
    20, // Total 20 pertemuan
    (index) => Meeting(isPresent: false),
  );
}

class BerandaPage extends StatelessWidget {
  final String username;
  const BerandaPage({super.key, required this.username});

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
              decoration: BoxDecoration(
                color: const Color(0xFF4D6FCE),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Selamat Datang,\n$username!",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink,
                    child: Text(
                      "😄",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ],
              ),
            ),

            // List Mata Pelajaran
            Expanded(
              child: Container(
                height: 400,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    buildSubjectButton(context, "Matematika"),
                    buildSubjectButton(context, "Fisika"),
                    buildSubjectButton(context, "Kimia"),
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
