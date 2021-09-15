import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newspaper_app/model/news_mode.dart';
import 'package:newspaper_app/screens/news_detial_screen.dart';
import 'package:newspaper_app/services/news_services.dart';

class Newscreen extends StatefulWidget {
  const Newscreen({Key key}) : super(key: key);

  @override
  _NewscreenState createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {
  Future _future;

  @override
  void initState() {
    _future = ApiServices().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder<NewsModel>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.articles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => newsDetail(
                            detail: snapshot.data.articles[index].description,
                            title: snapshot.data.articles[index].title,
                            imageurl: snapshot.data.articles[index].urlToImage,
                            source: snapshot.data.articles[index].source.name,
                          ),
                        ),
                      );
                      // Navigator.pushNamed(context, "/detailpafe",a);
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //let's add the height

                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data.articles[index].urlToImage),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              snapshot.data.articles[index].source.name,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            // "${snapshot.data.articles[index].title} hasfjhsafhashfpiashfiashfpjasnfnsakfnas",
                            snapshot.data.articles[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
