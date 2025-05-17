// import 'dart:io' show Platform;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'navbar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(const AbsensiApp());
// // }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Make sure Firebase is initialized
//   runApp(const AbsensiApp());
// }

// class AbsensiApp extends StatelessWidget {
//   const AbsensiApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Yohan Ganteng',
//       home: NavbarPage(),
//     );
//   }
// }


// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'navbarGuru.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// // ...



// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> navigatorKeyGuru = GlobalKey<NavigatorState>();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

//   runApp(
//     const GuruApp(),
//   );
// }

// class GuruApp extends StatelessWidget {
//   const GuruApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorKey: navigatorKeyGuru,
//       home: NavbarGuruPage(), // Gunakan GetX NavbarPage
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/sign_up.dart';
import 'sign_up.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      home: SignUpPage(isStudent: true,),
      debugShowCheckedModeBanner: false,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp();
//     runApp(const AbsensiApp());
//   } catch (e) {
//     print('Firebase failed to initialize: $e');
//   }
// }

// class AbsensiApp extends StatelessWidget {
//   const AbsensiApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: FirestoreButtonPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class FirestoreButtonPage extends StatelessWidget {
//   const FirestoreButtonPage({super.key});

//   Future<void> addDummyData(BuildContext context) async {
//     try {
//       CollectionReference users = FirebaseFirestore.instance.collection('users');

//       await users.add({
//         'name': 'Tatang',
//         'email': 'tatang@example.com',
//         'createdAt': Timestamp.now(),
//       });

//       print('✅ Dummy data added!');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ Dummy data added to Firestore!')),
//       );
//     } catch (e) {
//       print('❌ Error adding data: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('📦 Building FirestoreButtonPage');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Firestore Dummy'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: ElevatedButton.icon(
//           onPressed: () => addDummyData(context),
//           icon: const Icon(Icons.cloud_upload),
//           label: const Text('Add Dummy Data to Firestore'),
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }

