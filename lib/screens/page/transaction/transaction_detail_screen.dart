import "dart:async";
import "dart:convert";

import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import 'package:adamulti_mobile_clone_new/components/dynamic_size_button_outlined_icon_component.dart';
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/print_markup_container_component.dart";
import "package:adamulti_mobile_clone_new/components/receipt_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/cetak_mobile_response.dart";
import "package:adamulti_mobile_clone_new/model/connected_bluetooth_data.dart";
import "package:adamulti_mobile_clone_new/model/parsed_cetak_response.dart";
import "package:adamulti_mobile_clone_new/model/struk_model.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:esc_pos_utils_plus/esc_pos_utils_plus.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_blue_plus/flutter_blue_plus.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import "package:print_bluetooth_thermal/print_bluetooth_thermal.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

class TransactionDetailScreen extends StatefulWidget {

  const TransactionDetailScreen({ super.key, required this.idtrx, required this.total, required this.type });

  final String idtrx;
  final int total;
  final String type;

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {

  final screenshotController = ScreenshotController();

  @override
  void initState() {
    // PrintBluetoothThermal.isPermissionBluetoothGranted.then((permission) {
    //   print("PERMISSION : ");
    //   print(permission);
    // });

    // PrintBluetoothThermal.bluetoothEnabled.then((enabled) {
    //   print("ENABLED : ");
    //   print(enabled);
    // });

    final transactionDetailCubit = context.read<TransactionDetailCubit>();
    transactionDetailCubit.updateState(transactionDetailCubit.state.isPrinting, FormatCurrency.convertToIdr(widget.total, 0));

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
        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
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
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor2!),
                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor3!),
                          ],
                          stops: const [0, 0.4, 0.8],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      ),
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
                        printWidget: BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                          builder: (_, state) {
                            return state.isPrinting ? const SizedBox() :
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StreamBuilder(
                                  stream: FlutterBluePlus.adapterState, 
                                  builder: (context, snapshot) {
                                    return DynamicSizeButtonOutlinedIconComponent(
                                      label: "Print", 
                                      buttonColor: Colors.black, 
                                      onPressed: () async {
                                        if(snapshot.data == BluetoothAdapterState.on) {
                                          PrintBluetoothThermal.isPermissionBluetoothGranted.then((permission) {
                                            if(permission) {
                                              PrintBluetoothThermal.pairedBluetooths.then((listBluetoothPrinter) {
                                                locator.get<SecureStorageService>().readSecureData("printer").then((value) {
                                                  if(value != null) {
                                                    final deviceObject = ConnectedBluetoothData.fromJson(jsonDecode(value));

                                                    final printerRemoteId = listBluetoothPrinter.firstWhere((element) => element.name == deviceObject.deviceName);
                                                    PrintBluetoothThermal.connectionStatus.then((isConnectedStatus) {
                                                      if(isConnectedStatus) {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled: true,
                                                          shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(18),
                                                              topRight: Radius.circular(18)
                                                            )
                                                          ),  
                                                          builder: (_) {
                                                            return BlocProvider.value(
                                                              value: transactionDetailCubit,
                                                              child: PrintMarkupContainerComponent(
                                                                total: widget.total,
                                                                buttonLabel: "Print",
                                                                onSubmitAction: (String totalBayar, String markup) {
                                                                  printStruk(deviceObject.remoteId!, totalBayar, markup, (e) {
                                                                      showDynamicSnackBar(
                                                                        context, 
                                                                        Iconsax.warning_2, 
                                                                        "ERROR", 
                                                                        e.toString(), 
                                                                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          }
                                                        );
                                                      } else {
                                                        PrintBluetoothThermal.connect(macPrinterAddress: printerRemoteId.macAdress).then((isConnected) {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled: true,
                                                            shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(18),
                                                                topRight: Radius.circular(18)
                                                              )
                                                            ),  
                                                            builder: (_) {
                                                              return BlocProvider.value(
                                                                value: transactionDetailCubit,
                                                                child: PrintMarkupContainerComponent(
                                                                  total: widget.total,
                                                                  buttonLabel: "Print",
                                                                  onSubmitAction: (String totalBayar, String markup) {
                                                                    printStruk(deviceObject.remoteId!, totalBayar, markup, (e) {
                                                                        showDynamicSnackBar(
                                                                          context, 
                                                                          Iconsax.warning_2, 
                                                                          "ERROR", 
                                                                          e.toString(), 
                                                                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            }
                                                          );
                                                        });
                                                      }
                                                    });
                                                  } else {
                                                    showDynamicSnackBar(
                                                      context, 
                                                      Iconsax.warning_2, 
                                                      "ERROR", 
                                                      "Koneksikan Printer Anda Terlebih Dahulu pada Menu Account -> Connect Printer.", 
                                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                    );
                                                  }
                                                });
                                              });
                                            } else {
                                              showDynamicSnackBar(
                                                context, 
                                                Iconsax.warning_2, 
                                                "ERROR", 
                                                "Koneksikan Printer Anda Terlebih Dahulu pada Menu Account -> Connect Printer.", 
                                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                              );
                                            }
                                          });
                                        } else {
                                          showDynamicSnackBar(
                                            context, 
                                            Iconsax.warning_2, 
                                            "ERROR", 
                                            "Nyalakan Bluetooth dan Koneksikan Printer Anda Sebelum Melakukan Print.", 
                                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                          );
                                        }
                                      }, 
                                      width: 30.w, 
                                      height: 30,
                                      icon: Iconsax.printer,
                                    );
                                  }
                                ),
                                DynamicSizeButtonOutlinedIconComponent(
                                  label: "Share", 
                                  buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18)
                                        )
                                      ),  
                                      builder: (_) {
                                        return BlocProvider.value(
                                          value: context.read<TransactionDetailCubit>(),
                                          child: PrintMarkupContainerComponent(
                                            buttonLabel: "Share",
                                            total: widget.total,
                                            onSubmitAction: (String totalBayar, String markup) {
                                              transactionDetailCubit.updateState(true, transactionDetailCubit.state.totalReceipt);
                                              screenshotController.capture().then((screenshotResult) {
                                                Share.shareXFiles([
                                                  XFile.fromData(
                                                    screenshotResult!, 
                                                    mimeType: 'image/png', 
                                                    name: "transaksi_${snapshot.data!.idtrx}.png"
                                                  )
                                                ]).then((value) {
                                                  transactionDetailCubit.updateState(false, transactionDetailCubit.state.totalReceipt);
                                                }).catchError((_) {
                                                  transactionDetailCubit.updateState(false, transactionDetailCubit.state.totalReceipt);
                                                });
                                              });
                                            },
                                          ),
                                        );
                                      }
                                    );
                                  }, 
                                  width: 30.w, 
                                  height: 30,
                                  icon: Iconsax.share5,
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
                          buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
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

  Future<void> printStruk(String remoteId, String total, String jasaloket, Function onError) async {
    locator.get<TransactionService>().cetakMobile(widget.idtrx, total, jasaloket).then((cetak) {
        locator.get<SecureStorageService>().readSecureData("struk").then((value) async {
          if(value != null) {
            final struk = StrukModel.fromJson(jsonDecode(value));
            final strukPrinter = await strukBytes(cetak, struk);
            PrintBluetoothThermal.writeBytes(strukPrinter);
            // await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 5, text: struk.nama!));
            // await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 5, text: struk.alamat!));
            // await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 5, text: cetak.struk!));
            // await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 5, text: struk.footer!));
          } else {
            // final strukPrinter = await strukBytes(cetak, StrukModel(nama: null, alamat: null, footer: null, markup: jasaloket));
            
            // PrintBluetoothThermal.writeBytes(strukPrinter);
            PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 5, text: cetak.struk!));
          }
        });
      }).catchError((e) {
        onError(e);
      });
  }

  Future<List<int>> strukBytes(CetakMobileResponse data, StrukModel struk) async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load(name: "OCD-100");
    final generator = Generator(
      PaperSize.mm58, profile,
    );

    bytes += generator.emptyLines(1);
    if(struk.nama != null) {
      bytes += generator.text(struk.nama!, styles: const PosStyles(align: PosAlign.center, fontType: PosFontType.fontA, bold: true));
    }
    if(struk.alamat != null) {
      bytes += generator.text(struk.alamat!, styles: const PosStyles(align: PosAlign.center),);
    }
    if(struk.nama != null || struk.nama != null) {
      bytes += generator.hr();
    }

    bytes += generator.text(
      data.struk!, 
      styles: const PosStyles(
        fontType: PosFontType.fontA, 
        bold: true, 
        align: PosAlign.left,
      )
    );
    // await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 5, text: data.struk!));

    bytes += generator.emptyLines(1);

    if(struk.footer != null) {
      bytes += generator.text(struk.footer!, styles: const PosStyles(align: PosAlign.center, fontType: PosFontType.fontA, bold: true));
    }

    bytes += generator.cut();

    return bytes;

  }
}