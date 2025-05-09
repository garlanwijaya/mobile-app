import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'BerandaPage.dart';
import 'sign_in.dart';
import 'navbar.dart';
import 'Profile.dart'; // ✅ Tambahkan baris ini

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // pastikan binding siap

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

  runApp(
    AbsensiApp(
      navigatorKey: navigatorKey,
      home: const BerandaPage(), // Ubah ke SignInPage() kalau ingin login dulu
    ),
  );
}

class AbsensiApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget home;

  const AbsensiApp({
    super.key,
    required this.navigatorKey,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: home,
      routes: {
        '/beranda': (context) => const BerandaPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}