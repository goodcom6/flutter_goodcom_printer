import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:gcprinter/gcprinter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion='Click the print button to test printing';

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  Future<Uint8List> readBytes(String path) async {
    try {
      ByteData data = await rootBundle.load(path);
      Uint8List imgData = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      return imgData;
    } catch (err) {
      rethrow;
    }
  }
  Future<Uint8List> _getAssetImage(String path) async {
    return await readBytes(path);
  }
  Future<void> _btnPirnt() async{
    Uint8List bytes = await _getAssetImage('assets/images/logo.png');
    Gcprinter.printImage(bytes, Gcprinter.alignCenter, false);
    Gcprinter.drawOneLine(Gcprinter.fontMediumBold);
    Gcprinter.drawCustom("Request Time", Gcprinter.fontMedium, Gcprinter.alignCenter);
    Gcprinter.drawCustom("10:03", Gcprinter.fontMediumBold, Gcprinter.alignCenter);
    Gcprinter.drawOneLine();
    Gcprinter.drawText("1 x", Gcprinter.fontSmallBold, "test", Gcprinter.fontSmallBold, "65.00", Gcprinter.fontSmallBold);
    Gcprinter.drawLeftRight("option1", "60.00", Gcprinter.fontDefault);
    Gcprinter.drawText("option2", Gcprinter.fontDefault, "", Gcprinter.fontDefault, "5.00", Gcprinter.fontDefault);
    Gcprinter.drawBarcode("test123", Gcprinter.alignCenter,Gcprinter.barcodeQrCode);
    Gcprinter.drawText("",0,"test123",Gcprinter.fontDefault,"",0);
    Gcprinter.drawOneLine();
    Gcprinter.drawCustom("Thanks!", Gcprinter.fontSmall, Gcprinter.alignCenter);
    Gcprinter.printText(true);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _btnPirnt,
          tooltip: 'print',
          child: Icon(Icons.print),
        ),
      ),
    );
  }
}
