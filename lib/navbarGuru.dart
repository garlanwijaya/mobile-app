import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'BerandaGuru.dart';
import 'RekapGuru.dart';
import 'ProfileGuru.dart';

class NavbarGuruController extends GetxController {
  var currentIndex = 0.obs;

  final pages = [
    const BerandaGuru(),
    const RekapGuru(),
    const ProfileGuru(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}

class NavbarGuruPage extends StatelessWidget {
  final NavbarGuruController controller = Get.put(NavbarGuruController());

  NavbarGuruPage({super.key});

  @override
  Widget build(BuildContext context) {
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
