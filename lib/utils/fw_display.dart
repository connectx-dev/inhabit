import 'package:flutter/cupertino.dart';

import 'fw_resources.dart';



class FwDisplay {
  static final FwDisplay _instance = FwDisplay._internal();
  late double width ;
  late double height;

  late double realWidth ;
  late double realHeight ;

  final double designWidth  = 430;
  final double designHeight = 932;

  late double devicePixelRatio ;

  FwDisplay._internal(){
    var media = MediaQuery.of(resources.context!) ;
    width = media.size.width;
    height = media.size.height;
    devicePixelRatio = media.devicePixelRatio ;
    realWidth = width*devicePixelRatio;
    realHeight = height*devicePixelRatio;
  }

  factory FwDisplay(){
    return _instance ;
  }
}

FwDisplay display = FwDisplay();

double alignByX(double value) => (display.width*value)/display.designWidth ;

double alignByY(double value) => (display.height*value)/display.designHeight ;

double centerOnDisplayByWidth(double widgetWidth) => display.width/2 - widgetWidth/2 ;