// import 'package:data_pass_demo/utils/get_di.dart' as di;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/utils/get_di.dart' as di;
import 'package:get_argument/view/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      // initialRoute: Routes.homePage,
      // getPages: getPages,
    );
  }
}
