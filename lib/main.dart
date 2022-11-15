import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Maps/maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/MyMap",
      getPages: [
        GetPage(name: "/MyMap", page: () => const MyMap()),
      ],
    );
  }
}
