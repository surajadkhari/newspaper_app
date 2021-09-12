import 'package:flutter/material.dart';
import 'package:newspaper_app/model/news_mode.dart';
import 'package:newspaper_app/services/news_services.dart';


class Newscreen extends StatefulWidget {
  const Newscreen({Key? key}) : super(key: key);

  @override
  _NewscreenState createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder<NewsModel>(
        future: ApiServices().getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(child: Text(snapshot.data!.articles[1].title));
          }
        },
      ),
    );
  }
}
