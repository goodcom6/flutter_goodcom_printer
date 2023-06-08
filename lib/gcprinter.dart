import 'dart:typed_data';

import 'gcprinter_platform_interface.dart';

class Gcprinter {
  static const int fontDefault = 0;
  static const int fontSmall = 1;
  static const int fontMedium = 2;
  static const int fontBig = 3;
  static const int fontDoubleHeight = 4;
  static const int fontDoubleWidth = 5;
  static const int fontSmallBold = 6;
  static const int fontMediumBold = 7;
  static const int fontBigBold = 8;
  static const int fontDoubleHeightBold = 9;
  static const int fontDoubleWidthBold = 10;

  static const int alignLeft = 1;
  static const int alignCenter = 2;
  static const int alignRight = 3;

  static const int barcodeUpca = 0;
  static const int barcodeUpce = 1;
  static const int barcodeEan8 = 2;
  static const int barcodeEan13 = 3;
  static const int barcodeCode128 = 4;
  static const int barcodeCode39 = 5;
  static const int barcodeCodeBar = 6;
  static const int barcodeItf = 7;
  static const int barcodeCode93 = 8;
  static const int barcodeQrCode = 0x80;

  ///Print the content in json format,
  ///which will be parsed by the printer according to
  ///the template and formatted for printing
  static void printJson(String json) {
    GcprinterPlatform.instance.printJson(json);
  }

  /// Print the image according to the file path.
  /// You can set the alignment position of the printed image
  /// and decide whether to automatically feed the paper.
  /// If you want to print the text after printing the logo,
  /// the paper will not be automatically fed.
  /// When using this API, you need to apply for read file permission,
  /// Need to add the
  /// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  /// to AndroidManifest.xml
  /// And add code similar to the following to the Flutter code:
  ///import 'package:permission_handler/permission_handler.dart';
  //
  // void main() async {
  //   final status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     // Permission granted
  //   } else {
  //     // Permission denied
  //   }
  // }
  static void printImageFile(String filePath, int align, bool isAutoFeed) {
    GcprinterPlatform.instance.printImageFile(filePath, align, isAutoFeed);
  }

  /// Print the image according to the image data.
  /// You can set the alignment position of the printed image,
  /// and decide whether to automatically feed the paper.
  /// If you want to print the text after printing the logo,
  /// the paper will not be automatically fed.
  static void printImage(Uint8List img, int align, bool isAutoFeed) {
    GcprinterPlatform.instance.printImage(img, align, isAutoFeed);
  }

  /// Print a blank line, similar to a newline
  static void drawNewLine() {
    drawText(" ", fontSmall, "", fontSmall, "", fontSmall);
  }

  /// Print a horizontal line, you can specify the thickness
  /// of the horizontal line by setting the font size,
  /// or you can directly use the default font without specifying the font size
  static void drawOneLine([int? fontSize]) {
    if (fontSize != null) {
      drawText('______________________________', fontSize, "", fontSmall, "",
          fontSmall);
    } else {
      drawText('______________________________', fontSmall, "", fontSmall, "",
          fontSmall);
    }
  }

  /// Print the text content, you can specify the position and font size of the printed text,
  /// and you can print the left, middle, and right text at the same time
  static void drawText(String strLeft, int fontLeft, String strMid, int fontMid,
      String strRight, int fontRight) {
    GcprinterPlatform.instance
        .drawText(strLeft, fontLeft, strMid, fontMid, strRight, fontRight);
  }

  /// Print text content, you can specify the size and position of the content
  static void drawCustom(String str, int fontSize, int align) {
    switch (align) {
      case alignCenter:
        drawText("", 0, str, fontSize, "", 0);
        break;
      case alignRight:
        drawText("", 0, "", 0, str, fontSize);
        break;
      default:
        drawText(str, fontSize, "", 0, "", 0);
        break;
    }
  }

  /// Print text content, you can print left-aligned and right-aligned content at the same time
  static void drawLeftRight(String left, String right, int fontSize) {
    drawText(left, fontSize, "", 0, right, fontSize);
  }

  /// Print image files, centered by default and do not automatically feed paper
  static void drawImage(String path) {
    printImageFile(path, Gcprinter.alignCenter, false);
  }

  /// Print barcodes, including qrcode, you can specify the alignment position
  /// and barcode type of the barcode
  /// The unit of height is pixels
  /// No width parameter is required, the width is determined by the specific barcode
  static void drawBarcode(String str, int align, int type, [int? height]) {
    if (height != null) {
      GcprinterPlatform.instance.drawHBarcode(str, align, type, height);
    } else {
      GcprinterPlatform.instance.drawBarcode(str, align, type);
    }
  }

  /// Print qrcode, you can specify the alignment position and height of qrcode
  /// The unit of height is pixels
  static void drawQrCode(String str, int align, [int? height]) {
    if (height != null) {
      GcprinterPlatform.instance
          .drawHBarcode(str, align, barcodeQrCode, height);
    } else {
      GcprinterPlatform.instance.drawBarcode(str, align, barcodeQrCode);
    }
  }

  /// Start printing. Except for image printing, other printing interfaces,
  /// such as drawText, just draw the printing content in the memory first,
  /// and the printing has not been started yet.
  /// This method is to print out the printing content in the memory.
  static void printText(bool isAutoFeed) {
    GcprinterPlatform.instance.printText(isAutoFeed);
  }

  /// Check whether printing is supported.
  /// This method returns true only on goodcom printers.
  /// This method allows the app to distinguish printers from different manufacturers.
  static Future<bool> isDeviceSupport() {
    return GcprinterPlatform.instance.isDeviceSupport();
  }
}
