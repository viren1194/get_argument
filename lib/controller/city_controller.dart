import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_argument/model/city_model.dart';

class CityController extends GetxController implements GetxService {
  List<CityModel> cities = [];
  List<String> states = [];

  String? selectedState;
  String? selectedCity;

  void updateState(String value) {
    selectedState = value;
    update();
  }

  void updateCity(String value) {
    selectedCity = value;
    update();
  }

  Future<void> loadCityData() async {
    final String data = await rootBundle.loadString('assets/cities.json');
    final List<dynamic> jsonList = json.decode(data);
    // cities = jsonList.map((json) => CityModel.fromJson(json)).toList();
    cities.assignAll(jsonList.map((json) => CityModel.fromJson(json)));
    states = cities
        .map((city) => city.state)
        .where((state) => state != null)
        .map((state) => state!)
        .toSet()
        .toList();
    print("states ===> ${states}");
    print("data ===> ${data}");
    print("jsonList ===> ${jsonList}");
    update();
  }
}