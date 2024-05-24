import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/popups/loaders.dart';
import '../model/news_model.dart';

class CategoryController extends GetxController {
  var newsList = <NewsModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchNews(String category) async {
    String url = 'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9485717cdce14c9880d70765714dec3e';

    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> articles = jsonData['articles'];

        newsList.assignAll(articles.map((article) => NewsModel.fromJson(article)).toList());
      } else {
        errorMessage('Failed to load news with status code: ${response.statusCode}');
      }
    } on FormatException{
      SLoaders.errorSnackBar(title: 'Invalid response format');
    } on SocketException{
      SLoaders.errorSnackBar(title: 'No Internet Connection');
    } on http.ClientException catch (e){
      SLoaders.errorSnackBar(title: 'Failed to load news: ${e.message}');
    } catch (e) {
      errorMessage('Failed to load news: $e');
    } finally {
      isLoading(false);
    }
  }
}
