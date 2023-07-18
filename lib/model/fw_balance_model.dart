
import 'package:flutter/foundation.dart';
import 'package:fuse_wallet/model/fw_main_model.dart';
import 'package:fuse_wallet/model/fw_model.dart';
import 'package:fuse_wallet/server/fw_response.dart';

import '../server/fw_server_api.dart';



class FwBalanceModel extends FwModel{
  FwBalance? _balance ;

  String get balance => _balance?.balance??"0";

  get balanceUp => true;

  String get balanceProcents => "Fuse";
  bool _showMore = false ;
  bool get isShowMore => _showMore ;

  get tokensCount {
    var count = _balance?.tokensList?.result?.length??0;
    if(!_showMore){
      return count > 3 ? 3 : count ;
    }
    return count ;
  }




  bool get nextAvailable{
    var count = _balance?.tokensList?.result?.length??0;
    return count > 3;
  }



  String get shortAddress {
    String address = _balance?.address??"" ;
    if(address.isNotEmpty){
      var p1 = address.substring(0,14) ;
      var p2 = address.substring(address.length -6) ;
      return "$p1.....$p2";
    }
    return address ;
  }

  String get fullAddress => _balance?.address??"" ;

  VoidCallback get onShowMoreClick => (){
      update(callback: (){
        _showMore = !_showMore ;
      }) ;
  };



  set currentBalance(FwBalance? currentBalance) => _balance = currentBalance ;

  FwTokenListItem? tokenAt(int index) {
    if(index < tokensCount){
      return _balance?.tokensList?.result?[index];
    }
    return null ;
  }

  void showTokenDetails(FwTokenListItem token) {
    applicationModel.tokenDetailsModel.token = token ;
    applicationModel.navigate(FwApplicationStates.detailsState) ;
  }

  Future<bool> updateBalance() async{
    _balance = await fuseServer.loadBalance(fullAddress) ;
    if (kDebugMode) {
      print("Balance update state = ${_balance?.isValid??false}") ;

    }return  _balance?.isValid??false ;
  }





}