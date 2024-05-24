import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_storage/get_storage.dart';

import '../../details_view_screen/detailed_view_screen.dart';
import '../../../utils/circular_container.dart';
import '../../../utils/constants/sizes.dart';

class HomeNewsList extends StatefulWidget {
  const HomeNewsList({
    Key? key,
    required this.title,
    required this.sourceName,
    required this.publishedAt,
    required this.urlToImage,
    required this.description,
    required this.url,
    required this.author,
    required this.content,
  }) : super(key: key);

  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String sourceName;
  final String publishedAt;
  final String author;
  final String content;

  @override
  _HomeNewsListState createState() => _HomeNewsListState();
}

class _HomeNewsListState extends State<HomeNewsList> {
  final box = GetStorage();

  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = box.read(widget.url) ?? false; // Initialize isLiked from storage
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      box.write(widget.url, isLiked); // Save the liked state to storage

      List<dynamic> savedItems = box.read('savedItems') ?? [];
      if (isLiked) {
        savedItems.add({
          'title': widget.title,
          'description': widget.description,
          'url': widget.url,
          'urlToImage': widget.urlToImage,
          'sourceName': widget.sourceName,
          'publishedAt': widget.publishedAt,
          'author': widget.author,
          'content': widget.content,
        });
      } else {
        savedItems.removeWhere((item) => item['url'] == widget.url);
      }
      box.write('savedItems', savedItems);
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailedView(
          title: widget.title,
          description: widget.description,
          url: widget.url,
          urlToImage: widget.urlToImage,
          sourceName: widget.sourceName,
          publishedAt: widget.publishedAt,
          author: widget.author,
          content: widget.content,
        ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: SSizes.defaultSpace / 2,
              horizontal: SSizes.defaultSpace / 1.8),
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
                            widget.title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: toggleLike,
                        ),
                      ],
                    ),
                    SizedBox(height: SSizes.spaceBtwItems),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.sourceName,
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: SSizes.spaceBtwItems / 4),
                        const SRoundedContainer(
                          height: 10,
                          width: 10,
                          radius: 10,
                          backgroundColor: Colors.redAccent,
                        ),
                        const SizedBox(width: SSizes.spaceBtwItems / 6),
                        Expanded(
                          child: Text(
                            widget.publishedAt,
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
                    imageUrl: widget.urlToImage,
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
    );
  }
}
