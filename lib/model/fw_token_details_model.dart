import 'dart:ui';

import 'package:fuse_wallet/model/fw_model.dart';
import 'package:fuse_wallet/server/fw_response.dart';

import '../ui/base/fw_base_state.dart';
import '../ui/base/fw_base_widget.dart';

class FwTokenDetailsModel extends FwModel{
  FwTokenListItem? token ;
  int _visibleCount = 4 ;

  get visibleCount => _visibleCount;

  bool get isShowMore => _visibleCount == 4 ;

  @override
  setState(FwBaseState<FwBaseWidget>? state) {
    super.setState(state);
    if(state == null) {
      _visibleCount == 4;
    }
  }

  VoidCallback get showMore => (){
    update(callback: (){
      if(_visibleCount == 4) {
        _visibleCount = 7 ;
      }
      else {
        _visibleCount = 4 ;
      }
    }) ;
  };



}