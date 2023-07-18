import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:fuse_wallet/utils/fw_display.dart';

import 'fw_base_widget.dart';

class FwBaseState<T extends FwBaseWidget> extends State<T> {
  @protected
  BuildContext? currentContext;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode focus = FocusScope.of(context);
            if (focus.hasPrimaryFocus) {
              focus.unfocus();
            }
          },
          child: Scaffold(body:_body()),
        ),
        onWillPop: () => Future(() => onWillPop()));
  }

  Widget _body() {
    return Container(
      width: display.width,
      height: display.height,
      padding: EdgeInsets.only(
        top: alignByY(44),
        left: alignByX(20),
        right: alignByX(20),
        bottom: alignByY(22),
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
      child: Stack(
        children: [
          ConstraintLayout(
            width: display.width,
            height: alignByY(24),
            children: [
               Image(
                width: alignByX(85),
                 height: alignByY(24),
                image: const AssetImage("assets/images/logo.png"),
                fit: BoxFit.fill,
              ).applyConstraint(left:parent.left,top: parent.top,),
               Icon(Icons.menu,size: alignByY(24),).applyConstraint(right:parent.right,top: parent.top,),
            ],
          ),
          Positioned(
                top: alignByY(46),
                left: 0,
                width: display.width -  alignByY(40),
                height: display.height -  alignByY(44),
              child: contentPage(display.width -  alignByY(40),display.height -  alignByY(44))),

        ],
      ),
    );
  }

  @protected
  Widget contentPage(double width,double height) => Container();

  @protected
  bool onWillPop() {
    return false;
  }

  ///
  /// Will rebuild this widget
  updateState({VoidCallback? callback}) {
    setState(() {
      callback?.call();
    });
  }

  @protected
  Color get backgroundColor => const Color(0xFFF2F2F2) ;



  @protected
  Widget get content => Container();
}
