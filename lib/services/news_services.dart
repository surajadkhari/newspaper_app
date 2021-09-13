// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newspaper_app/model/news_mode.dart';

class ApiServices {
  Future<NewsModel> getNews() async {
    const url =
        "https://newsapi.org/v2/everything?q=Apple&from=2021-09-12&sortBy=popularity&apiKey=827dea572df845ea9be0bd26e85f0746";
    var respond = await http.get(Uri.parse(url));
    if (respond.statusCode == 200) {
      var jsonData = jsonDecode(respond.body);
      NewsModel news = newsModelFromJson(respond.body);
      return news;
    } else {
      return null;
    }
  }
}
