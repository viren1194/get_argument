import 'dart:io';

import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:path_provider/path_provider.dart';

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
  var directory = await getApplicationDocumentsDirectory();
  var filePath =
      '${directory.path}/test/example.pdf'; // Full path to the PDF file
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
  return filePath;
}
