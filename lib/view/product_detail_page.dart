import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/model/product_model.dart';
import 'package:get_argument/view/image_view.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductModel product = Get.arguments;
  bool isImageLoaded = false;
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ''),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 350,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: product.images?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        ImageView(),
                        arguments: {
                          'images': product.images,
                          'index': index,
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        product.images?[index] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 0.7,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Text('Category name = ${product.category?.name ?? ''}'),
          const SizedBox(
            height: 20,
          ),
          Text('Description = ${product.description ?? ''}'),
          const SizedBox(
            height: 20,
          ),
          Text('Price = ${product.price ?? ''}'),
        ],
      ),
    );
  }
}
