import 'dart:collection';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gcprinter_platform_interface.dart';

/// An implementation of [GcprinterPlatform] that uses method channels.
class MethodChannelGcprinter extends GcprinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('Gcprinter');

  @override
  void printJson(String json) {
    methodChannel.invokeMethod("printJson", {"json": json});
  }

  @override
  void printImageFile(String filePath, int align, bool isAutoFeed) {
    var map = HashMap<String, Object>();
    map["file_path"] = filePath;
    map["align"] = align;
    map["auto_feed"] = isAutoFeed;
    methodChannel.invokeMethod("printImageFile", map);
  }

  @override
  void printImage(Uint8List img, int align, bool isAutoFeed) {
    var map = HashMap<String, Object>();
    map["data"] = img;
    map["align"] = align;
    map["auto_feed"] = isAutoFeed;
    methodChannel.invokeMethod("printImage", map);
  }

  @override
  void drawText(String strLeft, int fontLeft, String strMid, int fontMid,
      String strRight, int fontRight) {
    var map = HashMap<String, Object>();
    map["strLeft"] = strLeft;
    map["fontLeft"] = fontLeft;
    map["strMid"] = strMid;
    map["fontMid"] = fontMid;
    map["strRight"] = strRight;
    map["fontRight"] = fontRight;
    methodChannel.invokeMethod("drawText", map);
  }

  @override
  void drawBarcode(String str, int align, int type) {
    var map = HashMap<String, Object>();
    map["data"] = str;
    map["align"] = align;
    map["type"] = type;
    methodChannel.invokeMethod("drawBarcode", map);
  }

  @override
  void drawHBarcode(String str, int align, int type, int height) {
    var map = HashMap<String, Object>();
    map["data"] = str;
    map["align"] = align;
    map["type"] = type;
    map["height"] = height;
    methodChannel.invokeMethod("drawHBarcode", map);
  }

  @override
  void printText(bool isAutoFeed) {
    var map = HashMap<String, Object>();
    map["auto_feed"] = isAutoFeed;
    methodChannel.invokeMethod("printText", map);
  }

  @override
  Future<bool> isDeviceSupport() async {
    final bool isOk = await methodChannel.invokeMethod('isDeviceSupport');
    return isOk;
  }
  @override
  void openCashBox(){
    methodChannel.invokeMethod('openCashBox');
  }
  @override
  void showLcdImage(Uint8List img){
    var map = HashMap<String, Object>();
    map["data"] = img;
    methodChannel.invokeMethod("showLcdImage", map);
  }
}
