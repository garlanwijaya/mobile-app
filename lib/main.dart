import 'package:flutter/material.dart';
import 'sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DigiTend',
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}

//AbsensiApp()
// class AbsensiApp extends StatelessWidget {
//   const AbsensiApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const BerandaPage(),
//     );
//   }
// }