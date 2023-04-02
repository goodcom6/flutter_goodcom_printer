# gcprinter

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

void drawText(String strLeft,int fontLeft,String strMid,int fontMid,String strRight,int fontRight);
printText();
void printUriImage(String uri,int align,bool isAutoFeed);
void printImage(Uint8List img ,int align,bool isAutoFeed);

## Example

```
    final _gcprinterPlugin = Gcprinter();

    _gcprinterPlugin.drawText("1 x", 1, "product name", 2, "65.00", 1);
    _gcprinterPlugin.drawText("option1", 1, "", 0, "60.00", 1);
    _gcprinterPlugin.drawText("option2", 1, "", 0, "5.00", 1);
    _gcprinterPlugin.printText();
```