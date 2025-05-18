import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RekapitulasiMurid.dart';

class RekapGuru extends StatefulWidget {
  const RekapGuru({super.key});

  @override
  State<RekapGuru> createState() => _RekapGuruState();
}

class _RekapGuruState extends State<RekapGuru> {
  final List<String> subjects = ['Matematika', 'Fisika', 'Kimia'];
  String selectedSubject = 'Fisika'; // Default

  List<Map<String, dynamic>> siswaData = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot userSnapshot = await firestore.collection('users').get();

    List<Map<String, dynamic>> fetchedData = [];

    for (var userDoc in userSnapshot.docs) {
      final userData = userDoc.data() as Map<String, dynamic>;
      if (userData['role'] != 'Siswa') continue; // Hanya siswa saja

      final String username = userData['username'] ?? 'unknown';

      int hadir = 0;
      int tidakHadir = 0;

      final subjectCollection = firestore
          .collection('users')
          .doc(userDoc.id)
          .collection(selectedSubject);

      final QuerySnapshot schedulesSnapshot = await subjectCollection.get();

      for (var doc in schedulesSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['status'] == true) {
          hadir++;
        } else {
          tidakHadir++;
        }
      }

      fetchedData.add({
        'name': username,
        'hadir': hadir,
        'tidakHadir': tidakHadir,
      });
    }

    setState(() {
      siswaData = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF4D6FCE),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Text(
                "Pilih Rekapitulasi\nyang kamu inginkan!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown Mata Pelajaran
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<String>(
                value: selectedSubject,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                dropdownColor: Colors.white,
                items: subjects.map((subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSubject = newValue!;
                  });
                  fetchAttendanceData(); // Ambil data ulang saat mapel ganti
                },
              ),
            ),

            // Tabel data siswa
            Expanded(
              child: Column(
                children: [
                  // Header tabel
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'NAMA',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'HADIR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'TIDAK HADIR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 40), // Untuk ikon mata
                      ],
                    ),
                  ),

                  // Isi tabel
                  Expanded(
                    child: ListView.builder(
                      itemCount: siswaData.length,
                      itemBuilder: (context, index) {
                        final data = siswaData[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: const Border(
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    data['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data['hadir'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  data['tidakHadir'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.remove_red_eye_outlined),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RekapitulasiMurid(
                                            name: data['name'],
                                            selectedSubject: selectedSubject,
                                          ),
                                        ),
                                      );
                                    },
                              ),
                            ],
                          ),
                        );
                      },
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
