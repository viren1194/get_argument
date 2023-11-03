import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/controller/sample_controller.dart';
import 'package:get_argument/model/sample_model.dart'; // Import your model

class SampleScreen extends StatefulWidget {
  const SampleScreen({Key? key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  SampleController sampleController = Get.find();

  @override
  void initState() {
    super.initState();
    sampleController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SampleController>(
        builder: (sampleController) {
          return Column(
            children: [
              Text('payload id = ${sampleController.sampleModel?.payloadId ?? ""}'),
              Text('amount = ${sampleController.sampleModel?.amount ?? 0}'),
              if (sampleController.sampleModel != null && sampleController.sampleModel!.data != null)
                ListView.builder(
                  itemCount: sampleController.sampleModel!.data!.length,
                  itemBuilder: (context, index) {
                    final datum = sampleController.sampleModel!.data![index];
                    return ListTile(
                      title: Text('name = ${datum.name ?? ""}'),
                      subtitle: Text('surname = ${datum.surname ?? ""}'),
                    );
                  },
                )
              else
                Text('No data available'),
            ],
          );
        },
      ),
    );
  }
}
