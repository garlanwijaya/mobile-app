import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Deteksi platform (aman untuk web)
  if (kIsWeb) {
    print('Platform: Web');
  } else {
    if (Platform.isAndroid) {
      print('Platform: Android');
    } else if (Platform.isIOS) {
      print('Platform: iOS');
    } else if (Platform.isWindows) {
      print('Platform: Windows');
    } else if (Platform.isMacOS) {
      print('Platform: macOS');
    } else if (Platform.isLinux) {
      print('Platform: Linux');
    }
  }

  runApp(const AbsensiApp());
}

class AbsensiApp extends StatelessWidget {
  const AbsensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Absensi App',
      home: NavbarPage(),
    );
  }
}


// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'navbarGuru.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> navigatorKeyGuru = GlobalKey<NavigatorState>();

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Deteksi platform
//   if (kIsWeb) {
//     print('Platform: Web');
//   } else {
//     if (Platform.isAndroid) {
//       print('Platform: Android');
//     } else if (Platform.isIOS) {
//       print('Platform: iOS');
//     } else if (Platform.isWindows) {
//       print('Platform: Windows');
//     } else if (Platform.isMacOS) {
//       print('Platform: macOS');
//     } else if (Platform.isLinux) {
//       print('Platform: Linux');
//     }
//   }

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


