import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/controller/city_controller.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  // String? selectedState;
  // String? selectedCity;

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
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CommonDropdown(
                title: 'select state',
                prefixIcon: Icons.add,
                hint: "Select state",
                items: cityController.states.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                selectedValue: cityController.selectedState,
                onChanged: (newValue) {
                  cityController.updateState(newValue!);
                  // setState(() {
                  //   selectedState = newValue;
                  //   selectedCity = null;
                  // });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              CommonDropdown(
                title: 'select city',
                prefixIcon: Icons.remove,
                hint: "Select city",
                items: cityController.cities
                    .where((city) =>
                        city.state == cityController.selectedState &&
                        city.name != null)
                    .map((city) {
                  return DropdownMenuItem<String>(
                    value: city.name!,
                    child: Text(city.name!),
                  );
                }).toList(),
                selectedValue: cityController.selectedCity,
                onChanged: (newValue) {
                  cityController.updateCity(newValue!);
                  // setState(() {
                  //   selectedCity = newValue;
                  // });
                },
              ),

              ////// for state dropdown
              const SizedBox(
                height: 50,
              ),

              Text('Selected state: ${cityController.selectedState}'),
              Text('Selected city: ${cityController.selectedCity}'),
            ],
          ),
        );
      }),
    );
  }
}

class CommonDropdown extends StatelessWidget {
  final String title;
  final IconData prefixIcon;
  final String hint;
  final List<DropdownMenuItem<String>> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  CommonDropdown({
    required this.title,
    required this.prefixIcon,
    required this.hint,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon),
              border: InputBorder.none,
            ),
            items: items,
            value: selectedValue,
            hint: Text(hint),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
