import "dart:convert";

import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import 'package:adamulti_mobile_clone_new/components/dynamic_size_button_outlined_icon_component.dart';
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/print_markup_container_component.dart";
import "package:adamulti_mobile_clone_new/components/receipt_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/connect_printer_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/parsed_cetak_response.dart";
import "package:adamulti_mobile_clone_new/model/struk_model.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:blue_thermal_printer/blue_thermal_printer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:adamulti_mobile_clone_new/constant/printer_enum.dart" as printer_enum;
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

class TransactionDetailScreen extends StatefulWidget {

  const TransactionDetailScreen({ super.key, required this.idtrx,
  required this.date, required this.total });

  final String idtrx;
  final String date;
  final int total;

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {

  final blueThermalPrinter = BlueThermalPrinter.instance;

  final screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionDetailCubit = context.read<TransactionDetailCubit>();
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: kLightBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                builder: (_, state) {
                  return state.isPrinting ? const SizedBox() :
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      width: 100.w,
                      height: 40.h,
                      color: kMainThemeColor,
                    ),
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: FutureBuilder<ParsedCetakResponse>(
                  future: locator.get<TransactionService>().parseCetak(widget.idtrx), 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      return ReceiptContainerComponent(
                        data: snapshot.data!, 
                        idtrx: widget.idtrx, 
                        tanggal: widget.date,
                        total: widget.total,
                        printWidget: BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                          builder: (_, state) {
                            return state.isPrinting ? const SizedBox() :
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DynamicSizeButtonOutlinedIconComponent(
                                  label: "Print", 
                                  buttonColor: Colors.black, 
                                  onPressed: () async {
                                    blueThermalPrinter.isOn.then((isOn) {
                                      if(isOn!) {
                                        blueThermalPrinter.isConnected.then((value) {
                                          if(value == false) {
                                            locator.get<SecureStorageService>().readSecureData("printer").then((value) {
                                              if(value != null) {
                                                final deviceObject = jsonDecode(value);
                                                final device = BluetoothDevice.fromMap(deviceObject);
                                                blueThermalPrinter.connect(device);
                                                locator.get<ConnectPrinterCubit>().updateState(
                                                  [],
                                                  device,
                                                  false
                                                );
                      
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(18),
                                                      topRight: Radius.circular(18)
                                                    )
                                                  ),  
                                                  builder: (context) {
                                                    return PrintMarkupContainerComponent(
                                                      onSubmitAction: (String totalBayar, String markup) {
                                                        printStruk(snapshot.data!, totalBayar, markup, (e) {
                                                          showDynamicSnackBar(
                                                            context, 
                                                            LineIcons.exclamationTriangle, 
                                                            "ERROR", 
                                                            e.toString(), 
                                                            Colors.red
                                                          );
                                                        });
                                                      },
                                                      total: widget.total,
                                                    );
                                                  }
                                                );
                                              }
                                            });
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(18),
                                                  topRight: Radius.circular(18)
                                                )
                                              ),  
                                              builder: (context) {
                                                return PrintMarkupContainerComponent(
                                                  onSubmitAction: (String totalBayar, String markup) {
                                                    printStruk(snapshot.data!, totalBayar, markup, (e) {
                                                      showDynamicSnackBar(
                                                        context, 
                                                        LineIcons.exclamationTriangle, 
                                                        "ERROR", 
                                                        e.toString(), 
                                                        Colors.red
                                                      );
                                                    });
                                                  },
                                                  total: widget.total,
                                                );
                                                  
                                              }
                                            );
                                          }
                                        });
                                      } else {
                                        showDynamicSnackBar(
                                          context, 
                                          LineIcons.exclamationTriangle, 
                                          "ERROR", 
                                          "Hidupkan Bluetooth Anda lalu Hubungkan ke Printer.", 
                                          Colors.red
                                        );
                                      }
                                    });
                                  }, 
                                  width: 30.w, 
                                  height: 30,
                                  icon: LineIcons.print,
                                ),
                                DynamicSizeButtonOutlinedIconComponent(
                                  label: "Share", 
                                  buttonColor: kMainLightThemeColor, 
                                  onPressed: () {
                                    transactionDetailCubit.updateState(true);
                                    screenshotController.capture().then((screenshotResult) {
                                      Share.shareXFiles([
                                        XFile.fromData(
                                          screenshotResult!, 
                                          mimeType: 'image/png', 
                                          name: "transaksi_${snapshot.data!.idtrx}.png"
                                        )
                                      ]).then((value) {
                                        transactionDetailCubit.updateState(false);
                                      }).catchError((_) {
                                        transactionDetailCubit.updateState(false);
                                      });
                                    });
                                  }, 
                                  width: 30.w, 
                                  height: 30,
                                  icon: Icons.share_outlined,
                                ),
                              ],
                            );
                          }
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
              ),
              BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                builder: (_, state) {
                  return state.isPrinting ? const SizedBox() :
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: 100.w,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 8),
                        child: DynamicSizeButtonComponent(
                          buttonColor: kMainLightThemeColor,
                          onPressed: () {
                            context.pop();
                          },
                          label: "Kembali",
                          width: 100.w,
                          height: 50,
                        ),
                      ),
                    )
                  );
                }
              )
            ],
          )
        ),
      ),
    );
  }

  void printStruk(
    ParsedCetakResponse data, String total, String jasaloket, Function onError) {

    locator.get<TransactionService>().cetakMobile(widget.idtrx, total, jasaloket).then((cetak) {
      locator.get<SecureStorageService>().readSecureData("struk").then((value) {
        if(value != null) {
          final struk = StrukModel.fromJson(jsonDecode(value));
          blueThermalPrinter.printNewLine();
          if(struk.nama != null) {
            blueThermalPrinter.printCustom(struk.nama!, printer_enum.Size.medium.val, printer_enum.Align.center.val); 
          }
          if(struk.alamat != null) {
            blueThermalPrinter.printCustom(struk.alamat!, printer_enum.Size.medium.val, printer_enum.Align.center.val); 
          }
        }
        blueThermalPrinter.printCustom("==============================", printer_enum.Size.medium.val, printer_enum.Align.center.val);
        blueThermalPrinter.printCustom(cetak.struk!, printer_enum.Size.medium.val, printer_enum.Align.left.val);
        blueThermalPrinter.printNewLine();
        if(value != null) {
          final struk = StrukModel.fromJson(jsonDecode(value));
          if(struk.footer != null) {
            blueThermalPrinter.printCustom(struk.footer!, printer_enum.Size.medium.val, printer_enum.Align.center.val); 
          }
        }
        blueThermalPrinter
            .paperCut();
      });
    }).catchError((e) {
      onError(e);
    }); 
    
  }
}