
import 'package:fuse_wallet/ui/pages/fw_add_wallet_address_page.dart';
import 'package:fuse_wallet/ui/pages/fw_balance_page.dart';
import 'package:fuse_wallet/ui/pages/fw_details_page.dart';

import '../ui/base/fw_base_state.dart';
import '../ui/base/fw_base_widget.dart';
import '../ui/pages/fw_launching_page.dart';
import '../utils/fw_resources.dart';
import 'fw_add_address_model.dart';
import 'fw_balance_model.dart';
import 'fw_model.dart';
import 'fw_token_details_model.dart';


enum FwApplicationStates {
  launchingState,
  addWalletAddressState,
  balanceState,
  detailsState
}

class FwMainModel extends FwModel {
  static final FwMainModel _instance = FwMainModel._internal();
  final Map<FwApplicationStates,FwBaseWidget> _states = {};
  late FwApplicationStates _currentPage ;
  late FwAddAddressModel addAddressModel ;
  late FwBalanceModel balanceModel ;
  late FwTokenDetailsModel tokenDetailsModel ;
  bool _refreshStarted = false ;
  factory FwMainModel(){
    return _instance ;
  }

  FwMainModel._internal(){
    _states[FwApplicationStates.launchingState]        = const FwLaunchingWidget();
    _states[FwApplicationStates.addWalletAddressState] = const FwAddWalletAddressWidget();
    _states[FwApplicationStates.balanceState]          = const FwBalanceWidget();
    _states[FwApplicationStates.detailsState]          = const FwDetailsWidget();

    _currentPage = FwApplicationStates.launchingState ;
    addAddressModel = FwAddAddressModel();
    balanceModel = FwBalanceModel() ;
    tokenDetailsModel = FwTokenDetailsModel();
  }

  FwBaseWidget get currentPage => _states[_currentPage]??const FwLaunchingWidget();

  @override
  setState(FwBaseState? state) async {
   super.setState(state);
   if(state != null) {
     await resources.load();
     navigate(FwApplicationStates.addWalletAddressState);
   }
   else {
     _stopRefresh() ;
   }
  }



  navigate(FwApplicationStates state) {
    update(callback: (){

      if(_currentPage == FwApplicationStates.addWalletAddressState && state == FwApplicationStates.balanceState){
        _startRefresh() ;
      }
      else if(state == FwApplicationStates.addWalletAddressState){
        _stopRefresh() ;
      }

      _currentPage = state ;
    });
  }

  _startRefresh() {
    if(!_refreshStarted){
      _refreshStarted = true ;
      _refresh();
    }
  }

  _refresh({int timeout = 5}) async{
    await Future.delayed( Duration(seconds: timeout)) ;
    if(_refreshStarted) {
      var state = await balanceModel.updateBalance();
      if(state){
        if(_currentPage == FwApplicationStates.balanceState) {
          balanceModel.update() ;
        }
        else if(_currentPage == FwApplicationStates.detailsState) {
          tokenDetailsModel.update() ;
        }
      }
      if(_refreshStarted) {
        await _refresh(timeout: state ? 5 : 10);
      }
    }
  }

  _stopRefresh() {
    if(_refreshStarted){
      _refreshStarted = false ;
    }
  }
}

FwMainModel applicationModel = FwMainModel();