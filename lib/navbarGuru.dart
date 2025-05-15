import 'package:flutter/material.dart';
import 'main.dart';

Widget? navbarGuru({
  required int currentIndex,
  required Function(int) onTap,
  bool hide = false,
}) {
  if (hide) return null;

  const navbarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 40),
      label: 'Home Guru',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart, size: 40),
      label: 'Rekap Guru',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 40),
      label: 'Profile Guru',
    ),
  ];

  final safeIndex = (currentIndex >= 0 && currentIndex < navbarItems.length)
      ? currentIndex
      : -1;

  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(26),
      topRight: Radius.circular(26),
      bottomLeft: Radius.circular(26),
      bottomRight: Radius.circular(26),
    ),
    child: MediaQuery.removePadding(
      context: navigatorKeyGuru.currentContext!,
      removeBottom: true,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF4D6FCE),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: safeIndex,
        onTap: onTap,
        items: navbarItems,
      ),
    ),
  );
}
