import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_nav.dart";
import "package:adamulti_mobile_clone_new/components/dashed_separator.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/readonly_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TransferDynamicMainScreen extends StatefulWidget {

  const TransferDynamicMainScreen({ super.key, required this.idReseller, required this.namaReseller });

  final String idReseller;
  final String namaReseller;

  @override
  State<TransferDynamicMainScreen> createState() => _TransferDynamicMainScreenState();
}

class _TransferDynamicMainScreenState extends State<TransferDynamicMainScreen> {
  
  final identityController = TextEditingController();
  final topupController = TextEditingController();
  final pinController = TextEditingController();

  @override
  void initState() {
    identityController.text = widget.idReseller;
    super.initState();
  }

  @override
  void dispose() {
    identityController.dispose();
    topupController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              Column(
                children: [
                  CustomContainerAppBarWithNav(
                    title: "Transfer Saldo Agen", 
                    height: 80, 
                    onTapNav: () {
                      context.goNamed("daftar-agen");
                    }
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  ReadonlyTextFieldComponent(
                                    label: "ID Agen", 
                                    hint: "", 
                                    controller: identityController, 
                                    prefixIcon: Iconsax.personalcard, 
                                    onTapTextField: () {}
                                  ),
                                  const SizedBox(height: 8,),
                                  TopupTextFieldComponent(
                                    label: "Jumlah Transfer", 
                                    hint: "Minimal Rp. 50.000", 
                                    controller: topupController,
                                    prefixIcon: Iconsax.empty_wallet_change,
                                  ),
                                  const SizedBox(height: 18,),
                                  DynamicSizeButtonComponent(
                                    label: "Transfer Saldo", 
                                    buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                    onPressed: () {
                                      final amount = topupController.text.replaceAll(RegExp(r"\D"), "");
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18)
                                          )
                                        ), 
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(18),
                                                    topRight: Radius.circular(18)
                                                  )
                                                ),
                                                padding: const EdgeInsets.all(18),
                                                width: 100.w,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text("Konfirmasi Transfer Saldo", style: GoogleFonts.inter(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600
                                                          ),),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            }, 
                                                            icon: const Icon(Icons.close, color: Colors.black,)
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 18,),
                                                      const DashedSeparator(),
                                                      const SizedBox(height: 8,),
                                                      Table(
                                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                        columnWidths: const {
                                                          0: FixedColumnWidth(80),
                                                          1: FixedColumnWidth(15),
                                                          2: FlexColumnWidth()
                                                        },
                                                        children: [
                                                          TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  "ID Tujuan", 
                                                                  maxFontSize: 14,
                                                                  maxLines: 1,
                                                                  style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: const Color(0xff7f8fa6)
                                                                ),),
                                                              ),
                                                              TableCell(
                                                                child: Text(":", style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500
                                                                ),)
                                                              ),
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  identityController.text,
                                                                  maxLines: 1,
                                                                  maxFontSize: 14,
                                                                  style: GoogleFonts.inter(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w700
                                                                  ),
                                                                )
                                                              )
                                                            ]
                                                          ),
                                                          const TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                            ]
                                                          ),
                                                          TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  "Penerima", 
                                                                  maxFontSize: 14,
                                                                  maxLines: 1,
                                                                  style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: const Color(0xff7f8fa6)
                                                                ),),
                                                              ),
                                                              TableCell(
                                                                child: Text(":", style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500
                                                                ),)
                                                              ),
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  widget.namaReseller,
                                                                  maxLines: 1,
                                                                  maxFontSize: 14,
                                                                  style: GoogleFonts.inter(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w700
                                                                  ),
                                                                )
                                                              ),
                                                            ]
                                                          ),
                                                          const TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                            ]
                                                          ),
                                                          TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  "No. Tujuan", 
                                                                  maxFontSize: 14,
                                                                  maxLines: 1,
                                                                  style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: const Color(0xff7f8fa6)
                                                                ),),
                                                              ),
                                                              TableCell(
                                                                child: Text(":", style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500
                                                                ),)
                                                              ),
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  identityController.text,
                                                                  maxLines: 1,
                                                                  maxFontSize: 14,
                                                                  style: GoogleFonts.inter(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w700
                                                                  ),
                                                                )
                                                              ),
                                                            ]
                                                          ),
                                                          const TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                              TableCell(
                                                                child: SizedBox(height: 8,)
                                                              ),
                                                            ]
                                                          ),
                                                          TableRow(
                                                            children: [
                                                              TableCell(
                                                                child: AutoSizeText("Total", 
                                                                maxFontSize: 14,
                                                                maxLines: 1,
                                                                style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: const Color(0xff7f8fa6)
                                                                ),),
                                                              ),
                                                              TableCell(
                                                                child: Text(":", style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500
                                                                ),)
                                                              ),
                                                              TableCell(
                                                                child: AutoSizeText(
                                                                  FormatCurrency.convertToIdr(int.parse(amount), 0),
                                                                  maxLines: 1,
                                                                  maxFontSize: 14,
                                                                  style: GoogleFonts.inter(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w700
                                                                  ),
                                                                )
                                                              ),
                                                            ]
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8,),
                                                      const DashedSeparator(),
                                                      const SizedBox(height: 18,),
                                                      RegularTextFieldComponent(
                                                        label: "PIN",
                                                        hint: "Masukkan PIN Anda.", 
                                                        controller: pinController, 
                                                        validationMessage: "PIN Harus Diisi.",
                                                        prefixIcon: Iconsax.key,
                                                        isObsecure: true,
                                                      ),
                                                      const SizedBox(height: 18,),
                                                      DynamicSizeButtonComponent(
                                                        label: "Transfer Saldo", 
                                                        buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                                        onPressed: () {
                                                          if(pinController.text.isEmpty) {
                                                            showDynamicSnackBar(
                                                              context, 
                                                              Iconsax.warning_2, 
                                                              "ERROR", 
                                                              "PIN harus diisi terlebih dahulu", 
                                                              Colors.red
                                                            );
                                                          } else {
                                                            showLoadingSubmit(context, "Proses Transfer Saldo...");

                                                            locator.get<AuthService>().transferSaldoDownline(
                                                              locator.get<UserAppidCubit>().state.userAppId.appId, 
                                                              int.parse(amount), 
                                                              identityController.text, 
                                                              pinController.text
                                                            ).then((value) {
                                                              if(value.success! == false) {
                                                                context.pop();
                                                                showDynamicSnackBar(
                                                                  context, 
                                                                  Iconsax.warning_2, 
                                                                  "ERROR", 
                                                                    value.msg!, 
                                                                  Colors.red
                                                                );
                                                              } else {
                                                                pinController.clear();
                                                                topupController.clear();
                                                                context.pop();
                                                                // showDynamicSnackBar(
                                                                //   context, 
                                                                //   LineIcons.infoCircle, 
                                                                //   "SUKSES", 
                                                                //   "Transaksi ${snapshot.data!.data![index].namaproduk} berhasil dilakukan.", 
                                                                //   Colors.lightBlue
                                                                // );
                                                                locator.get<LocalNotificationService>().showLocalNotification(
                                                                  title: "Transfer Saldo", 
                                                                  body: "Transfer Saldo ke Downline ${widget.namaReseller} dengan ID Reseller ${identityController.text} berhasil dilakukan."
                                                                );
                                                              }
                                                            }).catchError((e) {
                                                              context.pop();
                                                              showDynamicSnackBar(
                                                                context, 
                                                                Iconsax.warning_2, 
                                                                "ERROR", 
                                                                e.toString(), 
                                                                Colors.red
                                                              );
                                                            });
                                                          }
                                                        }, 
                                                        width: 100.w, 
                                                        height: 50
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      );
                                    }, 
                                    width: 100.w, 
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}