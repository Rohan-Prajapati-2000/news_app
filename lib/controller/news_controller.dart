/// BY THIS WE CAN FETCH ONLY THAT NEWS IN WHICH urlToImage IS AVAILABLE
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';
import '../utils/popups/loaders.dart';

class NewsController extends GetxController {
  var newsList = <NewsModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  String url = 'https://newsapi.org/v2/everything?q=in&sortBy=publishedAt&apiKey=9485717cdce14c9880d70765714dec3e';

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> articles = jsonData['articles'];

        // Filter articles where urlToImage is not null
        final filteredArticles = articles.where((article) => article['urlToImage'] != null).toList();

        newsList.assignAll(filteredArticles.map((article) => NewsModel.fromJson(article)).toList());
      } else {
        errorMessage('Failed to load news with status code: ${response.statusCode}');
      }
    } on FormatException {
      SLoaders.errorSnackBar(title: 'Invalid response format');
    } on SocketException{
      SLoaders.errorSnackBar(title: 'No Internet Connection');
    } on http.ClientException catch(e){
      SLoaders.errorSnackBar(title: 'Failed to load news: ${e.message}');
    } catch (e) {
      errorMessage('Failed to load news: $e');
    } finally {
      isLoading(false);
    }
  }
}











// import 'dart:convert';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../model/news_model.dart';
// import '../utils/popups/loaders.dart';

// class NewsController extends GetxController {
//   var newsList = <NewsModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   String url = 'https://newsapi.org/v2/everything?q=in&sortBy=publishedAt&apiKey=9485717cdce14c9880d70765714dec3e';
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchNews();
//   }
//
//   Future<void> fetchNews() async {
//     try {
//       isLoading(true);
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         final List<dynamic> articles = jsonData['articles'];
//
//         newsList.assignAll(articles.map((article) => NewsModel.fromJson(article)).toList());
//       } else {
//         errorMessage('Failed to load news with status code: ${response.statusCode}');
//       }
//     } on FormatException {
//       SLoaders.errorSnackBar(title: 'Invalid response format');
//     } on SocketException{
//       SLoaders.errorSnackBar(title: 'No Internet Connection');
//     } on http.ClientException catch(e){
//       SLoaders.errorSnackBar(title: 'Failed to load news: ${e.message}');
//     } catch (e) {
//       errorMessage('Failed to load news: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }