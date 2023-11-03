import 'package:get/get.dart';
import 'package:get_argument/model/sample_model.dart';
import 'package:get_argument/utils/api_client.dart';

class SampleController extends GetxController implements GetxService {
  ApiClient apiClient;
  SampleController({required this.apiClient});

  SampleModel? sampleModel;

  Future<void> getData() async {
    Response response =
        await apiClient.getData('https://api.escuelajs.co/api/v1/products');

    if (response.statusCode == 200) {
      sampleModel = SampleModel.fromJson(response.body);
      update();
    }
  }
}
