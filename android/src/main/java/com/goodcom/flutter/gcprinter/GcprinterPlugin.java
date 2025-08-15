package com.goodcom.flutter.gcprinter;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;
import com.goodcom.gcprinter.GcPrinterHelper;

import java.io.File;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** GcprinterPlugin */
public class GcprinterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context mContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "Gcprinter");
    channel.setMethodCallHandler(this);
    mContext= flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "printJson": {
        String json = call.argument("json");
        GcPrinterHelper.getInstance().printJson(mContext,json);
      }
        break;
      case "printImageFile": {
        String uri = call.argument("file_path");
        Integer align = call.argument("align");
        boolean isAutoFeed = Boolean.TRUE.equals(call.argument("auto_feed"));
        if (uri != null) {
          File file = new File(uri);
          if (file.exists()) {
            Bitmap bitmap = BitmapFactory.decodeFile(file.getPath());
            GcPrinterHelper.getInstance().printBitmap(mContext, bitmap,align!=null?align:0, isAutoFeed);
          }
        }
      }
        break;
      case "printImage":
      {
        byte[] bytes = call.argument("data");
        Integer align = call.argument("align");
        boolean isAutoFeed = Boolean.TRUE.equals(call.argument("auto_feed"));
        if (bytes != null) {
            Bitmap bitmap = BitmapFactory.decodeByteArray(bytes,0,bytes.length);
          GcPrinterHelper.getInstance().printBitmap(mContext, bitmap,align!=null?align:0, isAutoFeed);
        }
      }
        break;
      case "drawText":
      {
        String strLeft=call.argument("strLeft");
        Integer fontLeft = call.argument("fontLeft");
        String strMid=call.argument("strMid");
        Integer fontMid = call.argument("fontMid");
        String strRight = call.argument("strRight");
        Integer fontRight = call.argument("fontRight");
        GcPrinterHelper.getInstance().drawText(strLeft,fontLeft!=null?fontLeft:0,strMid,fontMid!=null?fontMid:0,strRight,fontRight!=null?fontRight:0);
      }
        break;
      case "drawBarcode": {
        String str = call.argument("data");
        Integer align = call.argument("align");
        Integer type = call.argument("type");
        GcPrinterHelper.getInstance().drawBarcode(str,align!=null?align:0,type!=null?type:0);
      }
      break;
      case "drawHBarcode":{
        String str = call.argument("data");
        Integer align = call.argument("align");
        Integer type = call.argument("type");
        Integer height = call.argument("height");
        GcPrinterHelper.getInstance().drawBarcode(str,align!=null?align:0,type!=null?type:0,height!=null?height:0);
      }
      break;
      case "printText":
      {
        boolean isAutoFeed = Boolean.TRUE.equals(call.argument("auto_feed"));
        GcPrinterHelper.getInstance().printText(mContext,isAutoFeed);
      }
      break;
      case "isDeviceSupport":
      {
        boolean isSupport=GcPrinterHelper.getInstance().isDeviceSupport();
        result.success(isSupport);
      }
        break;
      case "openCashBox":
      {
          GcPrinterHelper.getInstance().openCashBox(mContext);
      }
        break;
      case "showLcdImage":
      {
        byte[] bytes = call.argument("data");
        if (bytes != null) {
          Bitmap bitmap = BitmapFactory.decodeByteArray(bytes,0,bytes.length);
          GcPrinterHelper.getInstance().showLcdBitmap(mContext,bitmap);
        }
      }
      break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
