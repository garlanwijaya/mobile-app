import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'BerandaGuru.dart';
import 'RekapGuru.dart';
import 'ProfileGuru.dart';

// Global navigator key untuk guru
final GlobalKey<NavigatorState> navigatorKeyGuru = GlobalKey<NavigatorState>();

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

  runApp(
    GuruApp(
      navigatorKey: navigatorKeyGuru,
      home: const BerandaGuru(),
    ),
  );
}

class GuruApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget home;

  const GuruApp({
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
        '/berandaGuru': (context) => const BerandaGuru(),
        // '/rekapGuru': (context) => const RekapGuru(),
        // '/profileGuru': (context) => const ProfileGuru(),
      },
    );
  }
}
