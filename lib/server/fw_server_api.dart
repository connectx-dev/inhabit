

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'fw_response.dart';

class FwServer {
  final serverHost = "explorer.fuse.io" ;
  final Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json'};
  static final FwServer _instance = FwServer._internal();

  FwServer._internal() ;

  factory FwServer(){
    return _instance ;
  }

  Future<FwBalance> loadBalance(String address,{int timeoutSeconds=10}) async {
    try {
      final queryParameters = {
        'module': 'account',
        'action': 'eth_get_balance',
        'address':  address.trim()
      };
      final uri = Uri.https(serverHost, '/api', queryParameters);
      Response response = await http.get(uri).timeout( Duration(seconds: timeoutSeconds));
      if (kDebugMode) {
        print(response) ;
      }
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print(json) ;
      }
      FwBalance balance =   FwBalance.fromJson(json) ;
      if(balance.isValid){
        balance.address = address ;
        balance.tokensList = await loadTokens(address);
      }
      return balance ;
    }
    catch(err,stack){
      if (kDebugMode) {
        print(err) ;
        print(stack) ;
      }
      return  FwBalance.fromJson({"message":err.toString(),"status":-1}) ;
    }
  }

  /// Get ERC-20 or ERC-721 token total supply by contract address.
  Future<FwTokenTotalSupply> loadTokenTotalSupply(String address,{int timeoutSeconds=10}) async {
    try {
      final queryParameters = {
        'module': 'stats',
        'action': 'tokensupply',
        'contractaddress':  address.trim()
      };
      final uri = Uri.https(serverHost, '/api', queryParameters);



      Response response = await http.get(uri).timeout( Duration(seconds: timeoutSeconds));
      if (kDebugMode) {
        print(response) ;
      }
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print(json) ;
      }
      return  FwTokenTotalSupply.fromJson(json) ;
    }
    catch(err,stack){
      if (kDebugMode) {
        print(err) ;
        print(stack) ;
      }
      return  FwTokenTotalSupply.fromJson({"message":err.toString(),"status":-1}) ;
    }
  }

  ///
  /// Load list tokens for given wallet address
  Future<FwTokenList> loadTokens(String address,{int timeoutSeconds=10}) async {
    try {
      final queryParameters = {
        'module': 'account',
        'action': 'tokenlist',
        'address':  address.trim()
      };
      final uri = Uri.https(serverHost, '/api', queryParameters);



      Response response = await http.get(uri).timeout( Duration(seconds: timeoutSeconds));
      if (kDebugMode) {
        print(response) ;
      }
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print(json) ;
      }
      FwTokenList list =   FwTokenList.fromJson(json) ;
      if(list.isValid){
        for(FwTokenListItem item in list.result!){
          item.tokensTotalSupply = await loadTokenTotalSupply(item.contractAddress??"");
        }
      }
      return list ;
    }
    catch(err,stack){
      if (kDebugMode) {
        print(err) ;
        print(stack) ;
      }
      return  FwTokenList.fromJson({"message":err.toString(),"status":-1}) ;
    }
  }
}

FwServer fuseServer = FwServer();