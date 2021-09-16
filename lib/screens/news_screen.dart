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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Top News",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.search),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "seach", enabled: false),
                    autocorrect: false,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<NewsModel>(
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
                                  detail:
                                      snapshot.data.articles[index].description,
                                  title: snapshot.data.articles[index].title,
                                  imageurl:
                                      snapshot.data.articles[index].urlToImage,
                                  source:
                                      snapshot.data.articles[index].source.name,
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
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          snapshot
                                              .data.articles[index].source.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 80,
                                        width: 200,
                                        child: Text(
                                            snapshot.data.articles[index].title,
                                            maxLines: 2,
                                            style: TextStyle(
                                                height: 1.5,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot.data
                                                .articles[index].urlToImage))),
                                  ),
                                )
                              ],
                            ),
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       height: 200.0,
                            //       width: double.infinity,
                            //       decoration: BoxDecoration(
                            //         //let's add the height

                            //         image: DecorationImage(
                            //             image: NetworkImage(snapshot
                            //                 .data.articles[index].urlToImage),
                            //             fit: BoxFit.cover),
                            //         borderRadius: BorderRadius.circular(12.0),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 8.0,
                            //     ),
                            //     Container(
                            //       padding: EdgeInsets.all(6.0),
                            //       decoration: BoxDecoration(
                            //         color: Colors.red,
                            //         borderRadius: BorderRadius.circular(30.0),
                            //       ),
                            //       child: Text(
                            //         snapshot.data.articles[index].source.name,
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 8.0,
                            //     ),
                            //     Text(
                            //       // "${snapshot.data.articles[index].title} hasfjhsafhashfpiashfiashfpjasnfnsakfnas",
                            //       snapshot.data.articles[index].title,
                            //       maxLines: 2,
                            //       overflow: TextOverflow.clip,
                            //       style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 16.0,
                            //       ),
                            //     )
                            //   ],
                            // ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Nav()
        ],
      ),
    );
  }
}

class Nav extends StatefulWidget {
  const Nav({Key key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List _widgetOption = [
    Text("data"),
    Text("Categories"),
    Text("Search"),
  ];

  void _onItemselect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Catergories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            title: Text('Save'),
          ),
        ]);
  }
}
