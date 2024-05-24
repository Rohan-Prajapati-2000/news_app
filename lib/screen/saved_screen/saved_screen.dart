import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/utils/constants/sizes.dart';
import '../details_view_screen/detailed_view_screen.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final box = GetStorage();

  List<dynamic> get savedItems => box.read('savedItems') ?? [];

  void removeItem(String url) {
    setState(() {
      List<dynamic> updatedItems = savedItems.where((item) => item['url'] != url).toList();
      box.write('savedItems', updatedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
      ),
      body: ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          var item = savedItems[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => DetailedView(
                title: item['title'],
                description: item['description'],
                url: item['url'],
                urlToImage: item['urlToImage'],
                sourceName: item['sourceName'],
                publishedAt: item['publishedAt'],
                author: item['author'],
                content: item['content'],
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SSizes.defaultSpace / 1.8,
                      vertical: SSizes.defaultSpace),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['title'],
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite, color: Colors.red),
                                  onPressed: () => removeItem(item['url']),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  item['sourceName'],
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    item['publishedAt'],
                                    style: Theme.of(context).textTheme.caption,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: item['urlToImage'],
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
