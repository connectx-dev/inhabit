import 'package:flutter/cupertino.dart';
import 'package:fuse_wallet/model/fw_main_model.dart';
import 'package:fuse_wallet/model/fw_model.dart';
import 'package:fuse_wallet/server/fw_response.dart';

import '../server/fw_server_api.dart';

class FwAddAddressModel extends FwModel {

  String _address = "" ;
  bool _comminicationInProgress = false ;


  ValueChanged<String> get address => (String value) {
    update(callback: (){
      _address = value;
    }) ;
  } ;



  get currentAddress => _address;

  bool get continueAllowed => _address.trim().isNotEmpty ;

  bool get communicationInProgress => _comminicationInProgress ;

  VoidCallback get continueWithAddress => ()  {
    update(callback: () async {
      _comminicationInProgress = true ;
      FwBalance balance = await fuseServer.loadBalance(_address) ;
      update(callback: (){
        if (balance.isValid) {
          applicationModel.balanceModel.currentBalance = balance;
          applicationModel.navigate(FwApplicationStates.balanceState);
        }
        _comminicationInProgress = false;
      });
    });

  };


}