import 'dart:ui';

import '../ui/base/fw_base_state.dart';


/// The base class for any UI model in the project
class FwModel {
  FwBaseState? _modelState ;

  setState(FwBaseState? state){
    _modelState = state ;
  }

  update({VoidCallback? callback}) {
    if(_modelState != null) {
      _modelState!.updateState(callback: callback);
    }
  }
}