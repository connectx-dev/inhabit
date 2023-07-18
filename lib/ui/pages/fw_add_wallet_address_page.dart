import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:fuse_wallet/model/fw_main_model.dart';
import 'package:fuse_wallet/utils/fw_display.dart';

import '../../utils/fw_resources.dart';
import '../base/fw_base_state.dart';
import '../base/fw_base_widget.dart';

class FwAddWalletAddressWidget extends FwBaseWidget {
  const FwAddWalletAddressWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FwAddWalletAddressWidgetState();
}

class _FwAddWalletAddressWidgetState extends FwBaseState<FwAddWalletAddressWidget> {


  @override
  void initState() {
    super.initState();
    applicationModel.addAddressModel.setState(this);
  }

  @override
  void dispose() {
    super.dispose();
    applicationModel.addAddressModel.setState(null);
  }

  @override
  Widget contentPage(double width, double height) => Stack(
        children: [
          Positioned(
              top: alignByY(214),
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
                          left: alignByX(20),
                          top: alignByY(24),
                          child: Text(
                            localise("add_wallet_address"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: alignByY(20),
                              fontFamily: 'Mona-Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                      Positioned(
                          left: alignByX(20),
                          top: alignByY(67),
                          height: alignByY(48),
                          width: alignByX(350),
                          child: TextFormField(
                            controller: TextEditingController(text: applicationModel.addAddressModel.currentAddress),
                            textAlign: TextAlign.start,
                            onChanged: applicationModel.addAddressModel.address,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: alignByY(16),
                              fontFamily: 'Mona-Sans',
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: alignByX(16.50),
                                left: alignByY(16.30),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF2F2F2),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(alignByY(8)), borderSide: BorderSide.none),
                              hintText: localise("enter_or_copy_wallet_address"),
                              hintStyle: TextStyle(
                                color: const Color(0xFFBFBFBF),
                                fontSize: alignByY(16),
                                fontFamily: 'Mona-Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                      Positioned(
                          left: alignByX(20),
                          top: alignByY(139),
                          height: alignByY(48),
                          width: alignByX(350),
                          child: InkWell(

                              onTap: applicationModel.addAddressModel.continueAllowed  ? applicationModel.addAddressModel.continueWithAddress : null,
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.black.withOpacity(applicationModel.addAddressModel.continueAllowed ? 1 : 0.7),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: ConstraintLayout(
                                    width: matchParent,
                                    height: matchParent,
                                    children: [
                                      Visibility(visible:applicationModel.addAddressModel.communicationInProgress, child: const Padding(padding: EdgeInsets.only(left: 5,top: 5,bottom: 5),child: CircularProgressIndicator(color: Colors.white),)).applyConstraint(left:parent.left,top:parent.top,bottom: parent.bottom,height: matchConstraint),
                                      Text(
                                        localise("continue"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(applicationModel.addAddressModel.continueAllowed ? 1 : 0.7),
                                          fontSize: alignByY(16),
                                          fontFamily: 'Mona-Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ).applyConstraint(left: parent.left, right: parent.right, top: parent.top, bottom: parent.bottom),
                                    ],
                                  ))))
                    ],
                  ))),
          Positioned(top: alignByY(439), width: width, height: height - alignByY(439), child: ConstraintLayout(
            width: matchParent,
            height: matchParent,
            children: [
              ElevatedButton( onPressed: _scanQr,
              child:Icon(Icons.qr_code, size:width/4,color: Colors.black,)).applyConstraint(left: parent.left, right: parent.right, bottom: parent.center)
            ],
          ))
        ],
      );

  VoidCallback get _scanQr =>() async {
    try {
      String address = await FlutterBarcodeScanner.scanBarcode('#ffffffff', localise("cancel"), true, ScanMode.QR);
      if(address.isNotEmpty){
        applicationModel.addAddressModel.address(address);
      }
    }
    catch(err){
      if (kDebugMode) {
        print(err) ;
      }
    }
  } ;
}
