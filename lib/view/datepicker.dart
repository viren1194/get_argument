import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_argument/view/html_pdf.dart';
import 'package:get_argument/view/pdf_view.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime? _selectedDate;

  String _range = '';

  // Create an instance of the DateRangePicker
  late SfDateRangePicker dateRangePicker;

  @override
  void initState() {
    super.initState();

    dateRangePicker = SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.range,
      initialSelectedRange: PickerDateRange(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 3)),
      ),
      initialDisplayDate: _selectedDate,
      initialSelectedDate: _selectedDate,
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Use the dateRangePicker widget
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Pick Date',
                    content: SizedBox(
                      height: 300,
                      width: 300,
                      child: dateRangePicker,
                    ),
                  );
                },
                child: const Text("Show Date Range Picker"),
              ),
              Text("Selected Range: $_range"),
              Text("single Date: $_selectedDate"),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () async {
                    // convertToPdf();

                    // Get.to(PdfviewScreen());
                    await convertToPdf().then((filePath) {
                      Get.to(PdfviewScreen(filePath: filePath));
                    });
                  },
                  child: const Text('convert'))
            ],
          ),
        ),
      ),
    );
  }
}
