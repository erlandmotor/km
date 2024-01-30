import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import 'package:adamulti_mobile_clone_new/components/dynamic_size_button_outlined_icon_component.dart';
import "package:adamulti_mobile_clone_new/components/print_markup_container_component.dart";
import "package:adamulti_mobile_clone_new/components/receipt_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/parsed_cetak_response.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
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
                                DynamicSizeButtonOutlinedIconComponent(
                                  label: "Print", 
                                  buttonColor: Colors.black, 
                                  onPressed: () async {
                                    // Check Is ON
                                  }, 
                                  width: 30.w, 
                                  height: 30,
                                  icon: Iconsax.printer,
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
}