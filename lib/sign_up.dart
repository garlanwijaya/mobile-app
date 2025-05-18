import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_in.dart';

class SignUpPage extends StatefulWidget {
  final bool isStudent;

  const SignUpPage({super.key, required this.isStudent});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? selectedRole;
  final List<String> roles = ['Siswa', 'Guru'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd3eaff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Welcome to",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 24),

                // Container Form
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        controller: emailController,
                        decoration: inputDecoration('Email'),
                      ),
                      const SizedBox(height: 12),

                      // Username
                      TextFormField(
                        controller: usernameController,
                        decoration: inputDecoration('Username'),
                      ),
                      const SizedBox(height: 12),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: inputDecoration('Create Password'),
                      ),
                      const SizedBox(height: 12),

                      // Confirm Password
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: inputDecoration('Confirm Password'),
                      ),
                      const SizedBox(height: 12),

                      // Dropdown Role
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        hint: const Text('Pilih Role'),
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                        decoration: inputDecoration('Role'),
                      ),
                      const SizedBox(height: 24),

                      // Tombol Sign Up
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            final email = emailController.text.trim();
                            final username = usernameController.text.trim();
                            final password = passwordController.text;
                            final confirmPassword = confirmPasswordController.text;

                            if (email.isEmpty ||
                                username.isEmpty ||
                                password.isEmpty ||
                                confirmPassword.isEmpty ||
                                selectedRole == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Harap isi semua field dan pilih role')),
                              );
                              return;
                            }

                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password tidak cocok')),
                              );
                              return;
                            }

                            try {
                              // Start a Firestore batch
                              final batch = FirebaseFirestore.instance.batch();

                              // Create user document
                              final userRef = FirebaseFirestore.instance.collection('users').doc(username);
                              batch.set(userRef, {
                                'email': email,
                                'id' : username,
                                'username': username,
                                'role': selectedRole,
                                'password': password,
                                'created_at': Timestamp.now(),
                              });

                              // Create collections
                              if (selectedRole == 'Siswa') {
                                final collections = ['Matematika', 'Fisika', 'Kimia'];
                                for (var collection in collections) {
                                  for (int i = 1; i <= 20; i++) {
                                    final scheduleRef = userRef
                                        .collection(collection)
                                        .doc('schedule_$i');
                                    batch.set(scheduleRef, {
                                      'schedule_number': i,
                                      'created_at': Timestamp.now(),
                                      'status': false,
                                    });
                                  }
                                }
                              }

                              // Commit the batch
                              await batch.commit();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Registrasi berhasil')),
                              );

                              // Clear input
                              emailController.clear();
                              usernameController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                              setState(() {
                                selectedRole = null;
                              });

                              // Navigasi ke login
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Gagal menyimpan data: $e')),
                              );
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Link ke Sign In
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      floatingLabelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: const Color(0xFFF0F0F0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black, width: 0.5),
      ),
    );
  }
}