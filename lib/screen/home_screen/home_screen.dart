import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controller/news_controller.dart';
import 'package:news/utils/constants/sizes.dart';

import 'widget/home_news_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () => controller.fetchNews(), // Call fetchNews method when refreshing
          child: _buildNewsList(controller),
        );
      }),
    );
  }

  Widget _buildNewsList(NewsController controller) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.errorMessage.isNotEmpty) {
      return Center(child: Text(controller.errorMessage.value));
    } else {
      return ListView.builder(
        itemCount: controller.newsList.length,
        itemBuilder: (context, index) {
          final news = controller.newsList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace/4),
            child: HomeNewsList(
              title: news.title,
              sourceName: news.sourceName,
              publishedAt: news.publishedAt,
              urlToImage: news.urlToImage,
              description: news.description,
              url: news.url,
              author: news.author,
              content: news.content,
            ),
          );
        },
      );
    }
  }
}

