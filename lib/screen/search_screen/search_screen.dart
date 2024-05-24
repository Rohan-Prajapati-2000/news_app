import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news/controller/search_controller.dart';
import 'package:news/utils/constants/sizes.dart';

import '../home_screen/widget/home_news_list.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchControllers());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search News', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace/2, vertical: SSizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      final query = _searchController.text;
                      if (query.isNotEmpty) {
                        controller.searchNews(query);
                      }
                    },
                    icon: Icon(Iconsax.search_normal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusMd),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusMd),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  } else if (controller.searchResult.isEmpty) {
                    return Center(child: Text('No news found.'));
                  } else {
                    return ListView.builder(
                      itemCount: controller.searchResult.length,
                      itemBuilder: (context, index) {
                        var newsItem = controller.searchResult[index];
                        return HomeNewsList(
                          title: newsItem.title,
                          description: newsItem.description,
                          url: newsItem.url,
                          urlToImage: newsItem.urlToImage,
                          sourceName: newsItem.sourceName,
                          publishedAt: newsItem.publishedAt,
                          author: newsItem.author,
                          content: newsItem.content,
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
