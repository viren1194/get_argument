import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/model/body/product_body.dart';
import 'package:get_argument/model/product_model.dart';
import 'package:get_argument/utils/api_client.dart';
import 'package:get_argument/utils/app_const.dart';
import 'package:get_argument/view/product_list_page.dart';

class ProductController extends GetxController implements GetxService {
  ApiClient apiClient;
  ProductController({required this.apiClient});

  List<ProductModel> productList = <ProductModel>[];
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController image1Controller = TextEditingController();
  TextEditingController image2Controller = TextEditingController();
  int limit = 14;
  int offset = 0;
  int page = 1;
  bool hasMoreData = true;

  Future<void> getProductList() async {
    isLoading = true;
    Response response = await apiClient.getData(AppConstant.GETPRODUCT);

    if (response.statusCode == 200) {
      (response.body as List).forEach((element) {
        ProductModel productModel = ProductModel.fromJson(element);
        productList.add(productModel);
      });
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  // get product list
  Future<void> getProduct({int page = 1}) async {
    // offset = offset + limit;
    if (page == 1) {
      isLoading = true;
      hasMoreData = true;
      productList = [];
      this.page = 1;
      offset = 0; // Reset offset for the first page
    } else {
      // Calculate the next offset based on the previous offset and limit
      offset = offset + limit;
    }
    isLoading = true;
    Response response = await apiClient.getData(
        '${AppConstant.GETPRODUCT}?offset=$offset&limit=$limit'); //?offset=10&limit=10

    // print('response===> ${response.body}');
    // print(
    //     'next page ===> ${AppConstant.GETPRODUCT}?offset=$offset&limit=$limit');

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.body;
      if (responseData.isNotEmpty) {
        responseData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
        this.page++;
        // print('hello');
      } else {
        // No more data available
        hasMoreData = false;
      }

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  Future<void> createProduct({required ProductBody productBody}) async {
    Map<String, dynamic> body = productBody.toJson();
    Response response =
        await apiClient.postData(AppConstant.CREATEPRODUCT, body: body);

    if (response.statusCode == 201) {
      Get.to(const ProductListPage());
      Get.snackbar('Create', "Product Added Successfully!");
      update();
    }
  }

  Future<void> updateProduct(
      {required String id, required ProductBody productBody}) async {
    Map<String, dynamic> body = productBody.toJson();
    Response response =
        await apiClient.putData(AppConstant.CREATEPRODUCT + id, body);

    if (response.statusCode == 200) {
      Get.to(const ProductListPage());
      Get.snackbar('Update', "Product updated Successfully!");
      update();
    }
  }

  void initializeProductData(
      {required bool isEdit, required ProductModel product}) {
    if (isEdit) {
      titleController.text = product.title ?? '';
      priceController.text = product.price?.toString() ?? '';
      descriptionController.text = product.description ?? '';
      categoryIdController.text = product.category?.id?.toString() ?? '';
      image1Controller.text = product.images?[0] ?? '';
      image2Controller.text = product.images?[1] ?? '';
    }
  }

  Future<void> addOrUpdateProduct(
      {required bool isEdit, ProductModel? product}) async {
    ProductBody productBody = ProductBody(
      title: titleController.text,
      price: int.tryParse(priceController.text),
      description: descriptionController.text,
      categoryId: int.tryParse(categoryIdController.text),
      images: [image1Controller.text, image2Controller.text],
    );

    if (isEdit) {
      await updateProduct(
        id: product?.id.toString() ?? '',
        productBody: productBody,
      );

      print('isEdit == id == ${product?.id.toString()}');
    } else {
      await createProduct(productBody: productBody);

      print('isEdit = false');
    }
  }
}
