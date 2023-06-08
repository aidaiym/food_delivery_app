import 'package:flutter/material.dart';
import 'modules/main/view/main_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Food Delivery App',
      home: MainView(),
    );
  }
}
