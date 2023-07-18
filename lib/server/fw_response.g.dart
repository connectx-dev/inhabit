// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fw_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FwTokenListItem _$FwTokenListItemFromJson(Map<String, dynamic> json) =>
    FwTokenListItem()
      ..balance = json['balance'] as String?
      ..contractAddress = json['contractAddress'] as String?
      ..decimals = json['decimals'] as String?
      ..name = json['name'] as String?
      ..symbol = json['symbol'] as String?
      ..type = json['type'] as String?;

Map<String, dynamic> _$FwTokenListItemToJson(FwTokenListItem instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'contractAddress': instance.contractAddress,
      'decimals': instance.decimals,
      'name': instance.name,
      'symbol': instance.symbol,
      'type': instance.type,
    };

FwTokenList _$FwTokenListFromJson(Map<String, dynamic> json) => FwTokenList()
  ..message = json['message'] as String?
  ..status = json['status'] as String?
  ..result = (json['result'] as List<dynamic>?)
      ?.map((e) => FwTokenListItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FwTokenListToJson(FwTokenList instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'result': instance.result,
    };

FwBalance _$FwBalanceFromJson(Map<String, dynamic> json) => FwBalance()
  ..jsonrpc = json['jsonrpc'] as String?
  ..id = json['id'] as int?
  ..result = json['result'] as String?;

Map<String, dynamic> _$FwBalanceToJson(FwBalance instance) => <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result,
    };

FwTokenTotalSupply _$FwTokenTotalSupplyFromJson(Map<String, dynamic> json) =>
    FwTokenTotalSupply()
      ..message = json['message'] as String?
      ..status = json['status'] as String?
      ..result = json['result'] as String?;

Map<String, dynamic> _$FwTokenTotalSupplyToJson(FwTokenTotalSupply instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'result': instance.result,
    };
