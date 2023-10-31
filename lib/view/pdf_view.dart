import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get_argument/view/html_pdf.dart';

class PdfviewScreen extends StatefulWidget {
  final String filePath; // Add a filePath argument

  PdfviewScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  State<PdfviewScreen> createState() => _PdfviewScreenState();
}

class _PdfviewScreenState extends State<PdfviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PDFView(
          filePath: widget.filePath, // Provide the path to your PDF file
        ),
      ),
    );
  }
}
