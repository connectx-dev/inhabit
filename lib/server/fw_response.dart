import 'dart:ffi';
import 'dart:math';

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

  get priceInUsb => "35";

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

  String get balance => BigInt.parse(result!).toString() ;

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

