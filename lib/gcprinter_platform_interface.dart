import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gcprinter_method_channel.dart';

abstract class GcprinterPlatform extends PlatformInterface {
  /// Constructs a GcprinterPlatform.
  GcprinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static GcprinterPlatform _instance = MethodChannelGcprinter();

  /// The default instance of [GcprinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelGcprinter].
  static GcprinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GcprinterPlatform] when
  /// they register themselves.
  static set instance(GcprinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void printJson(String json) {
    throw UnimplementedError('printJson() has not been implemented');
  }

  void printImageFile(String filePath, int align, bool isAutoFeed) {
    throw UnimplementedError('printImageFile() has not been implemented');
  }

  void printImage(Uint8List img, int align, bool isAutoFeed) {
    throw UnimplementedError('printImage() has not been implemented');
  }

  void drawText(String strLeft, int fontLeft, String strMid, int fontMid,
      String strRight, int fontRight) {
    throw UnimplementedError('drawText() has not been implemented');
  }

  void drawBarcode(String str, int align, int type) {
    throw UnimplementedError('drawBarcode() has not been implemented');
  }

  void drawHBarcode(String str, int align, int type, int height) {
    throw UnimplementedError('drawHBarcode() has not been implemented');
  }

  void printText(bool isAutoFeed) {
    throw UnimplementedError('printText() has not been implemented');
  }

  Future<bool> isDeviceSupport() {
    throw UnimplementedError('isDeviceSupport() has not been implemented');
  }
}
