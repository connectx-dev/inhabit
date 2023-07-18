import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:fuse_wallet/utils/fw_display.dart';
import 'package:fuse_wallet/utils/fw_resources.dart';

import '../../model/fw_main_model.dart';
import '../../server/fw_response.dart';
import '../base/fw_base_state.dart';
import '../base/fw_base_widget.dart';

class FwBalanceWidget extends FwBaseWidget {
  const FwBalanceWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FwBalanceWidgetState();
}

class _FwBalanceWidgetState extends FwBaseState<FwBalanceWidget> {
  @override
  void initState() {
    super.initState();
    applicationModel.balanceModel.setState(this);
  }

  @override
  void dispose() {
    super.dispose();
    applicationModel.balanceModel.setState(null);
  }

  @override
  @protected
  bool onWillPop() {
    applicationModel.navigate(FwApplicationStates.addWalletAddressState);
    return false;
  }

  @override
  Widget contentPage(double width, double height) {
    ConstraintId buttonTitleId = ConstraintId("FwBalanceWidget_buttonTitleId");
    ConstraintId sumIdLabel = ConstraintId("FwBalanceWidget_sumId");
    ConstraintId procentIdLabel = ConstraintId("FwBalanceWidget_procentIdLabel");
    ConstraintId showMoreLabelId = ConstraintId("FwBalanceWidget_showMoreLabelId");
    ConstraintId popupTitleId = ConstraintId("FwBalanceWidget_popupTitleId");
    ConstraintId popupAddressId = ConstraintId("FwBalanceWidget_popupAddressId");
    ConstraintId exlamationMarkId = ConstraintId("FwBalanceWidget_exlamationMarkId");
    return Stack(
      children: [
        Positioned(
            top: alignByY(79),
            child: Text(
              localise("wallet"),
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
            height: alignByY(225),
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: alignByX(24),
                        top: alignByY(24),
                        child: Text(
                          localise("your_balance"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: alignByY(18),
                            fontFamily: 'Mona-Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    Positioned(
                      left: alignByX(20),
                      top: alignByY(70),
                      child: ConstraintLayout(
                        height: alignByY(48),
                        width: alignByX(350),
                        children: [
                          AutoSizeText(
                            applicationModel.balanceModel.balance,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: alignByY(20),
                              fontFamily: 'Mona-Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ).applyConstraint(id: sumIdLabel, left: parent.left, top: parent.top, bottom: parent.bottom),
                          Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(applicationModel.balanceModel.balanceProcents,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: alignByY(20),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ))).applyConstraint(id: procentIdLabel, left: sumIdLabel.right, top: parent.top, bottom: parent.bottom),

                        ],
                      ),
                    ),
                    Positioned(
                        left: alignByX(20),
                        top: alignByY(139),
                        height: alignByY(48),
                        width: alignByX(350),
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: alignByY(392),
                                      width: display.width,
                                      clipBehavior: Clip.antiAlias,
                                      padding: EdgeInsets.only(
                                        top: alignByY(40),
                                        left: alignByX(24),
                                        right: alignByX(24),
                                        bottom: alignByY(38),
                                      ),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(alignByY(12)),
                                            topRight: Radius.circular(alignByY(12)),
                                          ),
                                        ),
                                      ),
                                      child: ConstraintLayout(
                                        width: matchParent,
                                        height: matchParent,
                                        children: [
                                          Text(
                                            localise("your_public_address"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: alignByY(24),
                                              fontFamily: 'Mona-Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ).applyConstraint(id: popupTitleId, left: parent.left, right: parent.right, top: parent.top),
                                          Padding(
                                              padding: EdgeInsets.only(top: alignByY(24)),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: alignByY(16),
                                                  left: alignByX(17),
                                                  right: alignByY(17),
                                                  bottom: alignByX(16),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFF2F2F2),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(alignByY(8))),
                                                ),
                                                child: ConstraintLayout(
                                                  children: [
                                                    Text(
                                                      applicationModel.balanceModel.shortAddress,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: alignByY(16),
                                                        fontFamily: 'Mona-Sans',
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ).applyConstraint(left: parent.left, top: parent.top, bottom: parent.bottom),
                                                    InkWell(
                                                        onTap: () async {
                                                          await Clipboard.setData(ClipboardData(text: applicationModel.balanceModel.fullAddress));
                                                        },
                                                        child: const Icon(
                                                          Icons.copy,
                                                          color: Colors.black,
                                                        )).applyConstraint(right: parent.right, top: parent.top, bottom: parent.bottom),
                                                  ],
                                                ),
                                              )).applyConstraint(id: popupAddressId, left: parent.left, right: parent.right, top: popupTitleId.bottom, height: alignByY(82)),
                                          Padding(
                                              padding: EdgeInsets.only(top: alignByY(24)),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: alignByY(16.50),
                                                  left: alignByX(20),
                                                  right: alignByY(15.43),
                                                  bottom: alignByX(16.50),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFFFF8C5),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(alignByY(8))),
                                                ),
                                                child: ConstraintLayout(
                                                  children: [
                                                    Image(image: const AssetImage("assets/images/alert.png"), width: alignByX(24), height: alignByX(24)).applyConstraint(id: exlamationMarkId, left: parent.left, top: parent.top, bottom: parent.bottom),
                                                    Padding(
                                                        padding: EdgeInsets.only(left: alignByY(12)),
                                                        child: Text(
                                                          localise("make_sure_sending"),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: alignByY(16),
                                                            fontFamily: 'Mona-Sans',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )).applyConstraint(left: exlamationMarkId.right, top: parent.top, bottom: parent.bottom),
                                                  ],
                                                ),
                                              )).applyConstraint(left: parent.left, right: parent.right, top: popupAddressId.bottom, height: alignByY(104)),
                                          Padding(
                                              padding: EdgeInsets.only(top: alignByY(24)),
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(resources.context!).pop();
                                                  },
                                                  child: Container(
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: ShapeDecoration(
                                                        color: Colors.black,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      ),
                                                      child: ConstraintLayout(
                                                        width: matchParent,
                                                        height: matchParent,
                                                        children: [
                                                          Text(
                                                            localise("close"),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: alignByY(16),
                                                              fontFamily: 'Mona-Sans',
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ).applyConstraint(left: parent.left, right: parent.right, top: parent.top, bottom: parent.bottom),
                                                        ],
                                                      )))).applyConstraint(left: parent.left, right: parent.right, bottom: parent.bottom, height: alignByY(72))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: ConstraintLayout(
                                  width: matchParent,
                                  height: matchParent,
                                  children: [
                                    Text(
                                      localise("receive"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: alignByY(16),
                                        fontFamily: 'Mona-Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ).applyConstraint(id: buttonTitleId, left: parent.left, right: parent.right, top: parent.top, bottom: parent.bottom),
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                      size: alignByX(20),
                                    ).applyConstraint(right: buttonTitleId.left, top: buttonTitleId.top, bottom: buttonTitleId.bottom)
                                  ],
                                )))),
                  ],
                ))),
    Visibility(visible:applicationModel.balanceModel.tokensCount > 0, child:Positioned(
            top: alignByY(367),
            width: width,
            height: alignByY(applicationModel.balanceModel.isShowMore ? 450 : 367),
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: alignByX(24),
                        top: alignByY(24),
                        child: Text(
                          localise("your_coins"),
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
                        height: alignByY(applicationModel.balanceModel.isShowMore ? 315 : 240),
                        child: ListView.builder(
                          itemCount: applicationModel.balanceModel.tokensCount,
                          itemBuilder: (BuildContext context, int index) => tokenRow(context, index),
                        )),
                    Visibility(
                        visible: applicationModel.balanceModel.nextAvailable,
                        child: Positioned(
                            left: alignByX(0),
                            top: alignByY(applicationModel.balanceModel.isShowMore ? 390 : 303),
                            width: width,
                            height: alignByY(64),
                            child: InkWell(
                                onTap: applicationModel.balanceModel.onShowMoreClick,
                                child: ConstraintLayout(
                                  children: [
                                    const Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: Color(0xFFF2F2F2),
                                    ).applyConstraint(left: parent.left, right: parent.right, top: parent.top),
                                    Text(
                                      applicationModel.balanceModel.isShowMore  ? localise("show_less") : localise("show_more"),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: alignByY(18),
                                        fontFamily: 'Mona-Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ).applyConstraint(id: showMoreLabelId, left: parent.left, right: parent.right, bottom: parent.bottom, top: parent.top),
                                    Icon(applicationModel.balanceModel.isShowMore ? Icons.keyboard_arrow_up :  Icons.keyboard_arrow_down).applyConstraint(
                                      left: showMoreLabelId.right,
                                      bottom: showMoreLabelId.bottom,
                                      top: showMoreLabelId.top,
                                      height: matchConstraint,
                                    ),
                                  ],
                                ))))
                  ],
                )))),
      ],
    );
  }

  Widget tokenRow(BuildContext context, int index) {
    FwTokenListItem? token = applicationModel.balanceModel.tokenAt(index);
    ConstraintId itemImageID = ConstraintId("FwTokenListItem_image$index");
    ConstraintId itemBalanceID = ConstraintId("FwTokenListItem_balance$index");

    bool backgroundVisible = index % 2 == 0;
    if (token != null) {
      return InkWell(
          onTap: () {
            applicationModel.balanceModel.showTokenDetails(token);
          },
          child: ConstraintLayout(
            //width: alignByX(342),
            height: alignByY(64),
            children: [
              Visibility(
                  visible: backgroundVisible,
                  child: Container(
                      width: 342,
                      height: 64,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F2F2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ))).applyConstraint(left: parent.left, right: parent.right, top: parent.top, bottom: parent.bottom),
              Padding(
                  padding: EdgeInsets.only(left: alignByX(20)),
                  child: Image(
                    image: const AssetImage("assets/images/fdt_image.png"),
                    width: alignByX(41),
                    height: alignByX(41),
                  )).applyConstraint(id: itemImageID, left: parent.left, top: parent.top, bottom: parent.bottom),
              Padding(
                  padding: EdgeInsets.only(left: alignByX(8)),
                  child: Text(
                    token.name ?? "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: alignByX(18),
                      fontFamily: 'Mona-Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )).applyConstraint(left: itemImageID.right, top: parent.top, bottom: parent.bottom),
              Padding(
                  padding: EdgeInsets.only(right: alignByX(20)),
                  child: Text(
                    "${token.priceInUsb}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: alignByX(20),
                      fontFamily: 'Mona-Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  )).applyConstraint(id: itemBalanceID, right: parent.right, top: parent.top, bottom: parent.bottom),
            ],
          ));
    }
    return Container();
  }
}
