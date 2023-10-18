import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/view/product_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.to(const ProductListPage());
            },
            child: const Text("Product List")),
      ),
    );
  }
}
