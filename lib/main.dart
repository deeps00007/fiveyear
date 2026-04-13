import 'package:flutter/material.dart';
import 'views/loading_screen.dart';

void main() {
  runApp(const KidsGameApp());
}

class KidsGameApp extends StatelessWidget {
  const KidsGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ComicSans',
      ),
      home: const LoadingScreen(),
    );
  }
}
