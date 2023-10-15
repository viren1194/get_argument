import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/controller/product_controller.dart';
import 'package:get_argument/model/product_model.dart';
import 'package:get_argument/view/add_product.dart';
import 'package:get_argument/view/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductController productController = Get.find();
  @override
  void initState() {
    super.initState();
    productController.getProductList();
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
      body: GetBuilder<ProductController>(builder: (productController) {
        if (productController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            ProductModel product = productController.productList[index];
            return GestureDetector(
              onTap: () {
                Get.to(const ProductDetailPage(), arguments: product);
              },
              child: Card(
                child: ListTile(
                  title: Text(product.title ?? ''),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(
                          AddProduct(
                            isEdit: true,
                          ),
                          arguments: product);
                      
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
