import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_argument/view/html_pdf.dart';
import 'package:get_argument/view/pdf_view.dart';

class ConvertPdfPage extends StatefulWidget {
  const ConvertPdfPage({super.key});

  @override
  State<ConvertPdfPage> createState() => _ConvertPdfPageState();
}

class _ConvertPdfPageState extends State<ConvertPdfPage> {
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.complete;
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }
  @override
void dispose() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  super.dispose();
}

@pragma('vm:entry-point')
static void downloadCallback(String id, int status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await convertToPdf().then((filePath) {
                Get.to(PdfviewScreen(filePath: filePath));
              });
            },
            child: const Text('convert')),
      ),
    );
  }
}
