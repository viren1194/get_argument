// import 'package:data_pass_demo/utils/get_di.dart' as di;

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_argument/utils/get_di.dart' as di;
import 'package:get_argument/view/convert_pdf_page.dart';
import 'package:get_argument/view/dropdown.dart';
import 'package:get_argument/view/home_page.dart';
import 'package:get_argument/view/datepicker.dart';
import 'package:get_argument/view/pdf_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: ConvertPdfPage(),
      // initialRoute: Routes.homePage,
      // getPages: getPages,
    );
  }
}
