import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/image_strings.dart';
import 'widgets/category_news_list_screen.dart';
import 'widgets/category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Category Screen', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: CategoryWidget(image: SImage.business, title: 'Business', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'business'))),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: CategoryWidget(image: SImage.entertainment, title: 'Entertainment', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'entertainment'))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: CategoryWidget(image: SImage.general, title: 'General', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'general'))),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: CategoryWidget(image: SImage.health, title: 'Health', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'health'))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: CategoryWidget(image: SImage.science, title: 'Science', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'science'))),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: CategoryWidget(image: SImage.sports, title: 'Sports', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'sport'))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: CategoryWidget(image: SImage.technology, title: 'Technology', onTap: () => Get.to(()=> CategoryNewsListScreen(category: 'technology')))),
                    SizedBox(width: 5),
                    Expanded(child: SizedBox())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
