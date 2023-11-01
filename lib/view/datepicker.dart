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
  DateTime? startDate;
  DateTime? endDate;

  String _range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    startDate = args.value.startDate;
    endDate = args.value.endDate;
    print('start date ==> ${startDate}');
    print('end date ==> ${endDate}');
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
                  PickerDateRange? selectedDateRange;
                  Get.defaultDialog(
                    title: 'Pick Date',
                    content: SizedBox(
                      height: 300,
                      width: 300,
                      child: SfDateRangePicker(
                        showTodayButton: true,
                        showActionButtons: true,
                        todayHighlightColor: Colors.red,
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange:
                            PickerDateRange(startDate, endDate),
                        initialDisplayDate: startDate,
                        onSubmit: (dateRange) {
                          selectedDateRange = dateRange as PickerDateRange?;
                          Get.back();
                        },
                        onCancel: () {
                          Get.back();
                        },
                      ),
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
