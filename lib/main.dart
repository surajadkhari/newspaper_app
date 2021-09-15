import 'package:flutter/material.dart';

import 'screens/news_detial_screen.dart';
import 'screens/news_screen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Newscreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/detailpafe": (context) => newsDetail(),
      },
    );
  }
}
