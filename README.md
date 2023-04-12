# Gcprinter

This plugin allows the Flutter app to print tickets on a goodcom pos printer using a few simple apis.
This plugin support all the goodcom android pos printer.

## Installation

    flutter pub add gcprinter

## Main Features

1.Print text (you can set font size and alignment)
2.Print image (you can set alignment)
3.Print barcode or qrcode (Set barcode through parameters)

## Getting Started

```
// import packages
import 'package:gcprinter/gcprinter.dart';
```

## Function list

```
  void drawText(String strLeft,int fontLeft,String strMid,int fontMid,String strRight,int fontRight);
  void drawBarcode(String str,int align)
  void printText();
  void printImageFile(String filePath,int align,bool isAutoFeed);
  void printImage(Uint8List img ,int align,bool isAutoFeed);
//Easy to use API
  void drawNewLine();
  void drawOneLine([int? fontSize]);
  void drawCustom(String str,int fontSize,int align);
  void drawLeftRight(String left,String right,int fontSize);
  void drawImage(String path);
```

## Example

```
    Uint8List bytes = await _getAssetImage('assets/images/logo.png');
    Gcprinter.printImage(bytes, Gcprinter.alignCenter, false);
    Gcprinter.drawText("1 x", Gcprinter.fontSmallBold, "test", Gcprinter.fontSmallBold, "65.00", Gcprinter.fontSmallBold);
    Gcprinter.drawText("option1", Gcprinter.fontDefault, "", Gcprinter.fontDefault, "60.00", Gcprinter.fontDefault);
    Gcprinter.drawText("option2", Gcprinter.fontDefault, "", Gcprinter.fontDefault, "5.00", Gcprinter.fontDefault);
    Gcprinter.drawBarcode("test123", Gcprinter.alignCenter,Gcprinter.barcodeQrCode);
    Gcprinter.drawText("",0,"test123",Gcprinter.fontDefault,"",0);
    Gcprinter.printText(true);
```

## Different implementations of the same example

```
    Uint8List bytes = await _getAssetImage('assets/images/logo.png');
    Gcprinter.printImage(bytes, Gcprinter.alignCenter, false);
    Gcprinter.drawText("1 x", Gcprinter.fontSmallBold, "test", Gcprinter.fontSmallBold, "65.00", Gcprinter.fontSmallBold);
    Gcprinter.drawLeftRight("option1", Gcprinter.fontDefault, "60.00", Gcprinter.fontDefault);
    Gcprinter.drawLeftRight("option2", Gcprinter.fontDefault, "5.00", Gcprinter.fontDefault);
    Gcprinter.drawBarcode("test123", Gcprinter.alignCenter,Gcprinter.barcodeQrCode);
    Gcprinter.drawCustom("test123",Gcprinter.fontDefault,Gcprinter.alignCenter);
    Gcprinter.printText(true);
```