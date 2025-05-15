import 'package:flutter/material.dart';
import 'navbar.dart';

// Widget header modular khusus murid
class StudentProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String avatarPath;

  const StudentProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            backgroundImage: AssetImage(avatarPath),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman utama profil siswa
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F3),
      body: Column(
        children: [
          const StudentProfileHeader(
            name: 'Ashoka Tatang Solihin',
            role: 'Student',
            avatarPath: 'assets/avatar.png',
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

          // Tombol Logout
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
      bottomNavigationBar: navbar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/beranda');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/scan');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }

  // Widget untuk item menu
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
