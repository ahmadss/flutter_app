import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home_page.dart';
import 'package:flutter_app/screen/movie_detail.dart';
import 'package:flutter_app/screen/person_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail(),
        'person-detail': (BuildContext context) => PersonDetail(),
      },
    );
  }
}
