import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/news_detial_screen.dart';
import 'screens/news_screen.dart';
import 'screens/newshome_riverpod.dart';

void main() {
  runApp(ProviderScope(child: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsHomepage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/detailpafe": (context) => newsDetail(),
      },
    );
  }
}
