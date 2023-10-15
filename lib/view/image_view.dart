import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatefulWidget {
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  PageController pageController = PageController();

  List<String> images = [];
  int index = 0;
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    images = arguments['images'];
    index = arguments['index'];
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              images[index],
              fit: BoxFit.fitHeight,
            ),
          );
        },
      ),
    );
  }
}
