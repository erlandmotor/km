import "dart:convert";

import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dashed_separator.dart";
import "package:adamulti_mobile_clone_new/components/detail_transaksi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import 'package:adamulti_mobile_clone_new/components/dynamic_size_button_outlined_icon_component.dart';
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/print_markup_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/connect_printer_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/parsed_cetak_response.dart";
import "package:adamulti_mobile_clone_new/model/struk_model.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:blue_thermal_printer/blue_thermal_printer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:adamulti_mobile_clone_new/constant/printer_enum.dart" as printer_enum;
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

class TransactionDetailScreen extends StatefulWidget {

  const TransactionDetailScreen({ super.key, required this.idtrx, required this.type,
  required this.date, required this.total });

  final String idtrx;
  final String type;
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  width: 100.w,
                  height: 40.h,
                  color: kMainThemeColor,
                ),
              ), 
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: kWhiteBlueColor.withOpacity(0.2),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: kWhiteBlueColor.withOpacity(0.6),
                        child: const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.check_sharp, color: kMainThemeColor, size: 32,),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18,),
                    Text(widget.type == "HISTORY" ? "Riwayat Transaksi" : "Transaksi Berhasil", style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),),
                    const SizedBox(height: 4,),
                    Text(widget.date, style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),),
                    const SizedBox(height: 18,),
                    Expanded(
                      child: Card(
                        surfaceTintColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total Transaksi", style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryTextColor
                              ),),
                              const SizedBox(height: 4,),
                              Text(FormatCurrency.convertToIdr(widget.total, 0), style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: kMainLightThemeColor
                              ),),
                              const SizedBox(height: 18,),
                              const DashedSeparator(),
                              const SizedBox(height: 18),
                              Text("Detail Transaksi", style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kSecondaryTextColor
                              ),),
                              const SizedBox(height: 18,),
                              Expanded(
                                child: FutureBuilder<ParsedCetakResponse>(
                                  future: locator.get<TransactionService>().parseCetak(widget.idtrx),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done) {
                                      return Column(
                                        children: [
                                          if(snapshot.data!.idtrx != null)
                                          DetailTransaksiItemComponent(title: "ID Transaksi", value: snapshot.data!.idtrx!),
                                          if(snapshot.data!.rekening != null)
                                          DetailTransaksiItemComponent(title: "Rekening", value: snapshot.data!.rekening!),
                                          if(snapshot.data!.noTujuan != null)
                                          DetailTransaksiItemComponent(title: "No. Tujuan", value: snapshot.data!.noTujuan!),
                                          if(snapshot.data!.idpel != null)
                                          DetailTransaksiItemComponent(
                                            title: snapshot.data!.type! == "149" ? "KODE.VA" : "ID Pelanggan", 
                                            value: snapshot.data!.idpel!
                                          ),
                                          if(snapshot.data!.nama != null)
                                          DetailTransaksiItemComponent(title: "Nama", value: snapshot.data!.nama!),
                                          if(snapshot.data!.produk != null)
                                          DetailTransaksiItemComponent(title: "Produk", value: snapshot.data!.produk!),
                                          if(snapshot.data!.noMeter != null)
                                          DetailTransaksiItemComponent(title: "No. Meter", value: snapshot.data!.noMeter!),
                                          if(snapshot.data!.akun != null)
                                          DetailTransaksiItemComponent(title: "Akun", value: snapshot.data!.akun!),
                                          if(snapshot.data!.namaBank != null)
                                          DetailTransaksiItemComponent(title: "Nama Bank", value: snapshot.data!.namaBank!),
                                          if(snapshot.data!.sn != null)
                                          DetailTransaksiItemComponent(title: "SN", value: snapshot.data!.sn!),
                                          if(snapshot.data!.td != null)
                                          DetailTransaksiItemComponent(title: "TD", value: snapshot.data!.td!),
                                          if(snapshot.data!.ecommerce != null)
                                          DetailTransaksiItemComponent(title: "Ecommerce", value: snapshot.data!.ecommerce!),
                                          if(snapshot.data!.tarifDaya != null)
                                          DetailTransaksiItemComponent(title: "Tarif Daya", value: snapshot.data!.tarifDaya!),
                                          if(snapshot.data!.kodeBank != null)
                                          DetailTransaksiItemComponent(title: "Kode Bank", value: snapshot.data!.kodeBank!),
                                          if(snapshot.data!.kwh != null)
                                          DetailTransaksiItemComponent(title: "KWH", value: snapshot.data!.kwh!),
                                          if(snapshot.data!.standMeter != null)
                                          DetailTransaksiItemComponent(title: "Stand Meter", value: snapshot.data!.standMeter!),
                                          if(snapshot.data!.nominal != null)
                                          DetailTransaksiItemComponent(title: "Nominal", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.nominal!), 0)),
                                          if(snapshot.data!.blnTag != null)
                                          DetailTransaksiItemComponent(title: "JML Bulan", value: snapshot.data!.blnTag!),
                                          if(snapshot.data!.blnThn != null)
                                          DetailTransaksiItemComponent(title: "BLN/THN", value: snapshot.data!.blnThn!),
                                          if(snapshot.data!.jmlPeserta != null)
                                          DetailTransaksiItemComponent(title: "JML. Peserta", value: snapshot.data!.jmlPeserta!),
                                          if(snapshot.data!.adminBank != null)
                                          DetailTransaksiItemComponent(title: "ADMIN", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.adminBank!), 0)),
                                          if(snapshot.data!.jumlahTag != null)
                                          DetailTransaksiItemComponent(title: "JML. TAG", value: snapshot.data!.jumlahTag!),
                                          if(snapshot.data!.tarif != null)
                                          DetailTransaksiItemComponent(title: "Tarif", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.tarif!), 0)),
                                          if(snapshot.data!.angsuranKe != null)
                                          DetailTransaksiItemComponent(title: "Angsuran Ke", value: snapshot.data!.angsuranKe!),
                                          if(snapshot.data!.jatuhTempo != null)
                                          DetailTransaksiItemComponent(title: "Jatuh Tempo", value: snapshot.data!.jatuhTempo!),
                                          if(snapshot.data!.denda != null)
                                          DetailTransaksiItemComponent(title: "Denda", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.denda!), 0)),
                                          if(snapshot.data!.noReff != null)
                                          DetailTransaksiItemComponent(title: "No. Reff", value: snapshot.data!.noReff!),
                                          if(snapshot.data!.token != null)
                                          Column(
                                            children: [
                                              const SizedBox(height: 8,),
                                              Container(
                                                width: 100.w,
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: kWhiteBlueColor
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("No. Token : ", style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: kSecondaryTextColor
                                                    ),),
                                                    const SizedBox(height: 6,),
                                                    Text(
                                                      snapshot.data!.token!,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: kMainThemeColor
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 8,)
                                            ],
                                          ),
                                          const SizedBox(height: 18,),
                                          const DashedSeparator(),
                                          const SizedBox(height: 18,),
                                          BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
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
                                                    width: 40.w, 
                                                    height: 40,
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
                                                            mimeType: 'image/jpeg', 
                                                            name: "transaksi_${snapshot.data!.idtrx}.jpeg"
                                                          )
                                                        ]).then((value) {
                                                          transactionDetailCubit.updateState(false);
                                                        }).catchError((_) {
                                                          transactionDetailCubit.updateState(false);
                                                        });
                                                      });
                                                    }, 
                                                    width: 40.w, 
                                                    height: 40,
                                                    icon: Icons.share_outlined,
                                                  ),
                                                ],
                                              );
                                            }
                                          )
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                builder: (_, state) {
                  return state.isPrinting ? const SizedBox() :
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18))
                      ),
                      child: Column(
                        children: [
                          DynamicSizeButtonComponent(
                            buttonColor: kMainLightThemeColor,
                            onPressed: () {
                              context.pop();
                            },
                            label: "Kembali",
                            width: 100.w,
                            height: 50,
                          )
                        ],
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