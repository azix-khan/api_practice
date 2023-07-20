// import 'package:apis_practice/photos_screen.dart';
// import 'package:apis_practice/products_screen.dart';
import 'package:apis_practice/signup_screen.dart';
// import 'package:apis_practice/user_data_screen.dart';
// import 'package:apis_practice/users_screen.dart';
// import 'package:apis_practice/posts_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SignUpScreen(),
    );
  }
}
