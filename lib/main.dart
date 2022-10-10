import 'package:provider/provider.dart';
import 'package:tarea3/home_page.dart';
import 'package:flutter/material.dart';

import 'myprovider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<MyProvider>(create: (_) => MyProvider()),
        ],
        child: HomePage(),
      )
    );
  }
}
