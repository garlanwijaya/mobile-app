import 'package:flutter/material.dart';
import 'SubjectDetailsPage.dart';

Widget buildSubjectButton(BuildContext context, String title, String username) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailsPage(
              studentName: username,
              subjectName: title,
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
              decoration: const BoxDecoration(
                color: Color(0xFF4D6FCE),
                borderRadius: BorderRadius.only(
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    buildSubjectButton(context, "Matematika", username),
                    buildSubjectButton(context, "Fisika", username),
                    buildSubjectButton(context, "Kimia", username),
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
