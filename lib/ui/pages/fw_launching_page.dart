import 'package:flutter/cupertino.dart';

import '../base/fw_base_state.dart';
import '../base/fw_base_widget.dart';

class FwLaunchingWidget extends FwBaseWidget {
  const FwLaunchingWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FwLaunchingWidgetState();
}

class _FwLaunchingWidgetState
    extends FwBaseState<FwLaunchingWidget> {}
