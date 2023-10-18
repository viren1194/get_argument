import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/controller/product_controller.dart';
import 'package:get_argument/model/product_model.dart';
import 'package:get_argument/view/add_product.dart';
import 'package:get_argument/view/product_detail_page.dart';
import 'package:get_argument/view/shimmer/product_list_shimmer.dart';
import 'package:get_argument/view/shimmer/shimmer_loader.dart';
import 'package:get_argument/view/shimmer/single_image_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductController productController = Get.find();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // productController.getProductList();
    productController.getProduct();
    scrollController.addListener(scrollListner);
  }

  void scrollListner() {
    if (scrollController.positions.isNotEmpty) {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !productController.isLoading &&
          productController.hasMoreData) {
        productController.getProduct(page: productController.page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ProductController>(
        builder: (productController) {
          if (productController.isLoading) {
            return const ProductListShimmer();
          }
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: productController.productList.length,
                  itemBuilder: (context, index) {
                    ProductModel product = productController.productList[index];
                    return GestureDetector(onTap: () {
                      Get.to(const ProductDetailPage(),arguments: product);
                    },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: product.images?.first ?? '',
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.bounceOut,
                          placeholder: (context, url) {
                            return const singleImageShimmer();
                          },
                        ),
                      ),
                    );
                  },
                ),
                // if (productController.hasMoreData &&
                //     productController.productList.isNotEmpty) ...{

                //   Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         // Two horizontal shimmer placeholders
                //         Shimmer.fromColors(
                //           baseColor: Colors.grey[300]!,
                //           highlightColor: Colors.grey[100]!,
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(20),
                //             child: Container(
                //               width: 170,
                //               height: 350,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //         const SizedBox(width: 10),
                //         Shimmer.fromColors(
                //           baseColor: Colors.grey[300]!,
                //           highlightColor: Colors.grey[100]!,
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(20),
                //             child: Container(
                //               width: 170,
                //               height: 350,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // }
                if (productController.hasMoreData &&
                    productController.productList.isNotEmpty) ...{
                  const ShimmerLoader(),
                }
              ],
            ),
          );
        },
      ),
    );
  }
}

