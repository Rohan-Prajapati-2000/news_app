import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:news/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/popups/loaders.dart';

class SearchControllers extends GetxController {
  var searchResult = <NewsModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  String baseUrl = 'https://newsapi.org/v2/everything';
  String apiKey = '9485717cdce14c9880d70765714dec3e';

  Future<void> searchNews(String? query) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('$baseUrl?q=$query&sortBy=publishedAt&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> articles = jsonData['articles'];

        searchResult.assignAll(articles.map((article) => NewsModel.fromJson(article)).toList());
      } else {
        SLoaders.errorSnackBar(title: 'Failed to load news with status code: ${response.statusCode}');
      }
    } on SocketException {
      errorMessage('No internet connection');
    } on FormatException {
      errorMessage('Invalid response format');
    } on http.ClientException catch (e) {
      errorMessage('Failed to load news: ${e.message}');
    }catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to load news: $e');
    } finally {
      isLoading(false);
    }
  }
}
