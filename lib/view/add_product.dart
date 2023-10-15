import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/controller/product_controller.dart';
import 'package:get_argument/model/product_model.dart';

class AddProduct extends StatefulWidget {
  bool? isEdit;
  AddProduct({super.key, this.isEdit});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController = Get.find();
  late ProductModel product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.arguments != null) {
      product = Get.arguments;
      productController.initializeProductData(isEdit: true, product: product);
    } else {
      product = ProductModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit == true ? "Update" : " Add"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextField(
                controller: productController.titleController,
                decoration: InputDecoration(
                  hintText: "Enter title",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.priceController,
                decoration: InputDecoration(
                  hintText: "Enter price",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                // readOnly:  true ? true : false,
                controller: productController.categoryIdController,
                decoration: InputDecoration(
                  hintText: "Enter category Id",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.image1Controller,
                decoration: InputDecoration(
                  hintText: "Enter image 1 ",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.image2Controller,
                decoration: InputDecoration(
                  hintText: "Enter image 2",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.isEdit == true) {
                    productController.addOrUpdateProduct(
                        isEdit: true, product: product);
                  } else {
                    productController.addOrUpdateProduct(
                        isEdit: false, product: product);
                  }
                },
                child: Text(widget.isEdit == true ? "Update" : " Add"),
              )
            ],
          )),
    );
  }
}
