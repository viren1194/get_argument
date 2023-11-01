import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/controller/city_controller.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  String? selectedState;
  String? selectedCity;

  // List<Map<String, String>> citiesData = [
  //   {"id": "1", "name": "Mumbai", "state": "Maharashtra"},
  //   {"id": "2", "name": "Delhi", "state": "Delhi"},
  //   {"id": "3", "name": "Bengaluru", "state": "Karnataka"},
  //   {"id": "4", "name": "Ahmedabad", "state": "Gujarat"},
  //   {"id": "5", "name": "Hyderabad", "state": "Telangana"},
  //   {"id": "6", "name": "Chennai", "state": "Tamil Nadu"},
  //   {"id": "7", "name": "Kolkata", "state": "West Bengal"},
  //   {"id": "8", "name": "Pune", "state": "Maharashtra"},
  //   {"id": "9", "name": "Jaipur", "state": "Rajasthan"},
  //   {"id": "10", "name": "Surat", "state": "Gujarat"},
  //   {"id": "11", "name": "Lucknow", "state": "Uttar Pradesh"},
  //   {"id": "12", "name": "Kanpur", "state": "Uttar Pradesh"},
  //   {"id": "13", "name": "Nagpur", "state": "Maharashtra"},
  //   {"id": "14", "name": "Patna", "state": "Bihar"},
  //   {"id": "15", "name": "Indore", "state": "Madhya Pradesh"},
  //   {"id": "16", "name": "Thane", "state": "Maharashtra"},
  //   {"id": "17", "name": "Bhopal", "state": "Madhya Pradesh"},
  //   {"id": "18", "name": "Visakhapatnam", "state": "Andhra Pradesh"},
  //   {"id": "19", "name": "Vadodara", "state": "Gujarat"},
  //   {"id": "20", "name": "Firozabad", "state": "Uttar Pradesh"}
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<CityController>().loadCityData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<CityController>(builder: (cityController) {
        return Column(
          children: [
            ////// for state dropdown
            DropdownButton(
              items: cityController.states.map((state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              value: selectedState,
              onChanged: (newValue) {
                setState(() {
                  selectedState = newValue!;
                  selectedCity = null;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ////// for city dropdown
            DropdownButton(
              items: cityController.cities
                  .where((city) =>
                      city.state == selectedState && city.name != null)
                  .map((city) {
                return DropdownMenuItem<String>(
                  value: city.name!,
                  child: Text(city.name!),
                );
              }).toList(),
              value: selectedCity,
              onChanged: (newValue) {
                setState(() {
                  selectedCity = newValue ?? '';
                });
              },
            ),
            Text('Selected state: $selectedState'),
            Text('Selected city: $selectedCity'),
          ],
        );
      }),
    );
  }
}
