import 'package:flutter/material.dart';
import 'navbarGuru.dart';

class ProfileGuru extends StatelessWidget {
  const ProfileGuru({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F3),
      body: Column(
        children: [
          // Header Blue dengan Rounded
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF4D6FCE),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Garland Wijaya',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 24), // padding horizontal kanan saja
                        child: Divider(
                          thickness: 1,
                          color: Colors.white, // bisa diganti merah jika ingin
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Teacher',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Menu teks dengan garis bawah
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                menuItem('Help and Support'),
                menuItem('Term and Police'),
                menuItem('About'),
              ],
            ),
          ),

          const Spacer(),

          // Tombol Logout Merah
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(160, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: navbarGuru(
        currentIndex: 1,
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

  // Widget untuk menu teks dengan garis bawah
  Widget menuItem(String text) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
              ],
            ),
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
