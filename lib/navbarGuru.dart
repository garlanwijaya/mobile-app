import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'BerandaGuru.dart';
import 'RekapGuru.dart';
import 'ProfileGuru.dart';

class NavbarGuruController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final String username;

  late final List<Widget> pages;

  NavbarGuruController(this.username);

  @override
  void onInit() {
    super.onInit();
    pages = [
      BerandaGuru(username: username),
      RekapGuru(),
      ProfileGuru(username: username),
    ];
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}

class NavbarGuruPage extends StatelessWidget {
  final String username;

  NavbarGuruPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller dengan GetX
    final NavbarGuruController controller = Get.put(NavbarGuruController(username));

    return Obx(() => Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
              bottomLeft: Radius.circular(26),
              bottomRight: Radius.circular(26),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF4D6FCE),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 40),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart, size: 40),
                  label: 'Rekap',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 40),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ));
  }
}
