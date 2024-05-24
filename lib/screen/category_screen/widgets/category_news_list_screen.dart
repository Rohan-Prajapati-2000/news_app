import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/category_controller.dart';
import '../../home_screen/widget/home_news_list.dart';

class CategoryNewsListScreen extends StatefulWidget {
  final String category;

  CategoryNewsListScreen({super.key, required this.category});

  @override
  _CategoryNewsListScreenState createState() => _CategoryNewsListScreenState();
}

class _CategoryNewsListScreenState extends State<CategoryNewsListScreen> {
  final CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    controller.fetchNews(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} News'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.newsList.isEmpty) {
          return Center(child: Text('No news available'));
        } else {
          return ListView.builder(
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              final news = controller.newsList[index];
              return HomeNewsList(
                title: news.title,
                sourceName: news.sourceName,
                publishedAt: news.publishedAt,
                urlToImage: news.urlToImage,
                description: news.description,
                url: news.url,
                author: news.author,
                content: news.content,
              );
            },
          );
        }
      }),
    );
  }
}
