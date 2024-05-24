import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news/screen/saved_screen/saved_screen.dart';
import 'package:news/screen/search_screen/search_screen.dart';

import 'screen/category_screen/category_screen.dart';
import 'screen/home_screen/home_screen.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 60,
          elevation: 5,
          backgroundColor: Colors.red,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home",),
            NavigationDestination(icon: Icon(Iconsax.search_normal), label: "Search"),
            NavigationDestination(icon: Icon(Iconsax.category), label: "Category"),
            NavigationDestination(icon: Icon(Iconsax.heart), label: "Saved"),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [
    HomeScreen(),
    SearchScreen(),
    CategoriesScreen(),
    SavedScreen(),
  ];
}
