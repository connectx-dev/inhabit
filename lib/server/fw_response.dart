import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:fuse_wallet/utils/fw_resources.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:number_system/number_system.dart';
part 'fw_response.g.dart';

@JsonSerializable()
class FwTokenListItem {
  String? balance;
  String? contractAddress;
  String? decimals;
  String? name;
  String? symbol;
  String? type;

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  FwTokenTotalSupply? tokensTotalSupply ;

  get priceInUsb => calculatedBalance;

  num get calculatedBalance {
    num mod = pow(10.0, int.parse(decimals!));
    num b = double.parse(balance!) ;
    num r =  (b  / mod);
    if(r - r.toInt() > 0){
      return r ;
    }
    return r.toInt() ;
  }

  static FwTokenListItem fromJson(Map<String, dynamic> json) => _$FwTokenListItemFromJson(json) ;
}

@JsonSerializable()
class FwTokenList {
  String? message;
  String? status;
  List<FwTokenListItem>? result;


  static FwTokenList fromJson(Map<String, dynamic> json) =>  _$FwTokenListFromJson(json) ;

  bool get isValid => status!=null && status! == "1" ;
}

@JsonSerializable()
class FwBalance {
  String? jsonrpc;
  int? id;
  String? result;
  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  FwTokenList? tokensList ;

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  String address = "" ;

  String calculatePoints(String number,String realPart){
    String numberFormatted = "";
    do {
      if (realPart.length > 3) {
        if(numberFormatted.isEmpty) {
          numberFormatted = realPart.substring(realPart.length - 3);
        }
        else {
          numberFormatted = "${realPart.substring(realPart.length - 3)},$numberFormatted" ;
        }
        realPart = realPart.substring(0,realPart.length - 3) ;
      }
      else {
        numberFormatted = "$realPart,$numberFormatted" ;
        break ;
      }
    } while (number.length > 3);
    return numberFormatted  ;
  }

  String get balance {
    String number =  BigInt.parse(result!).toString() ;
    String decimalPart = "" ;

    if(number.length > 18){
      decimalPart = number.substring(number.length - 18);
      if(double.parse(decimalPart) == 0){
        number = number.substring(0,number.length - 18) ;
      }
    }
    String realPart = "" ;
    if(number.length > 18){
      decimalPart = number.substring(number.length - 18) ;
      realPart    = number.substring(0,number.length - 18) ;
      String numberFormatted = calculatePoints(number,realPart);
      return "$numberFormatted.$decimalPart"  ;
    }
    else {
      realPart    = number ;
      String numberFormatted = calculatePoints(number,realPart);
      String clearNum = numberFormatted.replaceAll(",", "");
      if(clearNum.length < number.length){
        decimalPart = number.substring(number.length - clearNum.length) ;
        return "$numberFormatted.$decimalPart"  ;
      }
      else {
        return numberFormatted ;
      }
    }
  }

  bool get isValid => result!=null && result!.isNotEmpty ;

  static FwBalance fromJson(Map<String, dynamic> json) =>  _$FwBalanceFromJson(json) ;
}

@JsonSerializable()
class FwTokenTotalSupply {
  String? message;
  String? status;
  String? result;
  static FwTokenTotalSupply fromJson(Map<String, dynamic> json) =>  _$FwTokenTotalSupplyFromJson(json) ;
}

