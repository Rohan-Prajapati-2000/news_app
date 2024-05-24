import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/circular_container.dart';
import 'package:news/utils/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedView extends StatelessWidget {
  DetailedView({
    Key? key,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.sourceName,
    required this.publishedAt,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: urlToImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(sourceName, style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2),
                    SizedBox(width: SSizes.spaceBtwItems),
                    SRoundedContainer(
                        height: 10,
                        width: 10,
                        radius: 10,
                        backgroundColor: Colors.grey),
                    SizedBox(width: SSizes.spaceBtwItems / 2),
                    Text(publishedAt, style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2),
                  ],
                ),
                const SizedBox(height: 10),
                Text(author, style: Theme
                    .of(context)
                    .textTheme
                    .subtitle2),
                const SizedBox(height: 10),
                Text(description, style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2),
                const SizedBox(height: 10),
                Text(content, style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication
                    );
                  },
                  child: Text(
                    url,
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
