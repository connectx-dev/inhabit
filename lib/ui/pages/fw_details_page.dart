import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

import '../../model/fw_main_model.dart';
import '../../utils/fw_display.dart';
import '../../utils/fw_resources.dart';
import '../base/fw_base_state.dart';
import '../base/fw_base_widget.dart';

class FwDetailsWidget extends FwBaseWidget {
  const FwDetailsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FwDetailsWidgetState();
}

class _FwDetailsWidgetState extends FwBaseState<FwDetailsWidget> {
  @override
  void initState() {
    super.initState();
    applicationModel.tokenDetailsModel.setState(this);
  }

  @override
  void dispose() {
    super.dispose();
    applicationModel.tokenDetailsModel.setState(null);
  }

  @override
  @protected
  bool onWillPop() {
    applicationModel.navigate(FwApplicationStates.balanceState);
    return false;
  }

  @override
  Widget contentPage(double width, double height) {
    ConstraintId showMoreLabelId = ConstraintId("FwBalanceWidget_showMoreLabelId");
    return Stack(children: [
      Positioned(
          top: alignByY(79),
          child: Text(
            localise("details"),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: alignByY(24),
              fontFamily: 'Mona-Sans',
              fontWeight: FontWeight.w700,
            ),
          )),
      Positioned(
          top: alignByY(125),
          width: width,
          height: applicationModel.tokenDetailsModel.isShowMore ? alignByY(590) :height,
          child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Stack(children: [
                Positioned(
                    left: alignByX(24),
                    top: alignByY(24),
                    child: Text(
                      applicationModel.tokenDetailsModel.token?.name ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: alignByY(18),
                        fontFamily: 'Mona-Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                Positioned(
                    left: alignByX(24),
                    top: alignByY(60),
                    width: width - alignByX(24) * 2,
                    height: applicationModel.tokenDetailsModel.isShowMore ? alignByY(420) : alignByY(560),
                    child: ListView.builder(
                      reverse: false,
                      itemCount: applicationModel.tokenDetailsModel.visibleCount,
                      itemBuilder: (BuildContext context, int index) => detailRow(context, index),
                    )),
                Positioned(
                    left: alignByX(0),
                    top: applicationModel.tokenDetailsModel.isShowMore ? alignByY(504): alignByY(630),
                    width: width,
                    height: alignByY(64),
                    child: InkWell(onTap: applicationModel.tokenDetailsModel.showMore,
                      child: ConstraintLayout(
                      children: [
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: Color(0xFFF2F2F2),
                        ).applyConstraint(left: parent.left, right: parent.right, top: parent.top),
                        Text(
                          applicationModel.tokenDetailsModel.isShowMore ? localise("show_more") : localise("show_less"),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: alignByY(18),
                            fontFamily: 'Mona-Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ).applyConstraint(id: showMoreLabelId, left: parent.left, right: parent.right, bottom: parent.bottom, top: parent.top),
                        Icon(applicationModel.tokenDetailsModel.isShowMore ? Icons.keyboard_arrow_down :  Icons.keyboard_arrow_up).applyConstraint(
                          left: showMoreLabelId.right,
                          bottom: showMoreLabelId.bottom,
                          top: showMoreLabelId.top,
                          height: matchConstraint,
                        ),
                      ],
                    )))
              ])))
    ]);
  }

  Widget detailRow(BuildContext context, int index) {
    bool backgroundVisible = index % 2 == 0;
    String title = "";
    String value = "";
    switch (index) {
      case 0:
        title = localise("symbol");
        value = applicationModel.tokenDetailsModel.token?.symbol ?? "";
        break;
      case 1:
        title = localise("name");
        value = applicationModel.tokenDetailsModel.token?.name ?? "";
        break;
      case 2:
        title = localise("total_supply");
        value = applicationModel.tokenDetailsModel.token?.tokensTotalSupply?.result ?? "";
        break;
      case 3:
        title = localise("decimals");
        value = applicationModel.tokenDetailsModel.token?.decimals ?? "";
        break;
      case 4:
        title = localise("balance");
        value = "${applicationModel.tokenDetailsModel.token?.calculatedBalance ?? ""}";
        break;
      case 5:
        title = localise("contractAddress");
        value = applicationModel.tokenDetailsModel.token?.contractAddress ?? "";
        break;
      case 6:
        title = localise("type");
        value = applicationModel.tokenDetailsModel.token?.type ?? "";
        break;
    }
    return ConstraintLayout(
      height: alignByY(100),
      children: [
        Visibility(
            visible: backgroundVisible,
            child: Container(

                height: alignByY(100),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF2F2F2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ))).applyConstraint(left: parent.left, right: parent.right, top: parent.top, bottom: parent.bottom),
        Padding(
            padding: EdgeInsets.only(left: alignByX(20), top: alignByY(23)),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: alignByY(18),
                fontFamily: 'Mona-Sans',
                fontWeight: FontWeight.w600,
              ),
            )).applyConstraint(left: parent.left, top: parent.top),
        Padding(
          padding: EdgeInsets.only(left: alignByX(20), bottom: alignByY(10)),
          child: Text(value,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: alignByY(18),
                fontFamily: 'Mona-Sans',
                fontWeight: FontWeight.w400,
              )),
        ).applyConstraint(left: parent.left, top:parent.center,bottom: parent.bottom),
      ],
    );
  }
}
