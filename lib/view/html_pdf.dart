import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

final htmlContent = '''
<h1>Heading Example</h1>
  <p>This is a paragraph.</p>
  <img src="image.jpg" alt="Example Image" />
  <blockquote>This is a quote.</blockquote>
  <ul>
    <li>First item</li>
    <li>Second item</li>
    <li>Third item</li>
  </ul>
''';

Future<String> convertToPdf() async {
  var customPath = '/storage/emulated/0/Download';
  final fileName = DateTime.now().millisecondsSinceEpoch;
  var filePath = '$customPath/$fileName.pdf';

  var directory = Directory(customPath);

  if (!(await directory.exists())) {
    print('Directory does not exist. Creating...');
    try {
      await directory.create(recursive: true);
      print('Directory created successfully.');
    } catch (e) {
      print('Error creating directory: $e');
    }
  }

  var file = File(filePath);
  var myTheme = ThemeData.withFont(
    base: Font.ttf(await rootBundle.load("fonts/Helvetica.ttf")),
    bold: Font.ttf(await rootBundle.load("fonts/Helvetica-Bold.ttf")),
  );
  final newpdf = Document(theme: myTheme);
  List<Widget> widgets = await HTMLToPdf().convert(htmlContent);
  newpdf.addPage(MultiPage(
      maxPages: 200,
      build: (context) {
        return widgets;
      }));
  await file.writeAsBytes(await newpdf.save());
  _downloadPdf(filePath, '$fileName.pdf');
  print("pdf saved ==> ${filePath}");
  return filePath;
}

void _downloadPdf(String filePath, String fileName) {
  final taskId = FlutterDownloader.enqueue(
    // url: filePath, // Use the local file path directly
    url: 'file://$filePath',
    savedDir: '/storage/emulated/0/Download',
    showNotification: true,
    openFileFromNotification: true,
    fileName: fileName,
    headers: {
      'Content-Type': 'application/pdf', // Optional content type header
    },
  );

  taskId.then((id) {
    FlutterDownloader.open(taskId: id!); // Open the downloaded file immediately
  }).catchError((error) {
    print('Error while enqueuing the download: $error');
  });
}
