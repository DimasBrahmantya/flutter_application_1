import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/article.dart';
class HttpController extends GetxController {
  // static const String _baseUrl = 'https://newsapi.org/v2/';
  // static const String _apiKey = 'e29f0cb9da69485489ef09d7b7ba32ba'; //Ganti ke API KEY yang sudah didapat
  // static const String _category = 'business';
  // static const String _country = 'us'; //us maksudnya United States ya
  static const String _baseUrl = 'https://my-json-server.typicode.com/Fallid/codelab-api/db';
  
  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async{
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final jsonData = response.body;
        final articlesResult = Articles.fromJson(json.decode(jsonData));
        articles.value = articlesResult.articles;
      }else{
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred :$e');
    } finally {
      isLoading.value = false;
    }
  }
  
}