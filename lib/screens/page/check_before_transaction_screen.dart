import "package:adamulti_mobile_clone_new/components/check_text_field_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/scan_barcode_component.dart";
import "package:adamulti_mobile_clone_new/components/select_contact_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/transaction_check_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/inbox_schema_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/schema/inbox_schema.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class CheckBeforeTransactionScreen extends StatefulWidget {

  const CheckBeforeTransactionScreen({ super.key, required this.operatorName, required this.kodeProduk });

  final String operatorName;
  final String kodeProduk;

  @override
  State<CheckBeforeTransactionScreen> createState() => _CheckBeforeTransactionScreenState();
}

class _CheckBeforeTransactionScreenState extends State<CheckBeforeTransactionScreen> {
  final identityController = TextEditingController();


  @override
  void dispose() {
    identityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final checkIdentityCubit = context.read<CheckIdentityCubit>();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBar(
                title: widget.operatorName,
                height: 90,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)
                    )
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: CheckTextFieldComponent(
                            label: "Masukkan ID Pelanggan", 
                            hint: "Conth: 123456",
                            controller: identityController,
                          ),),
                          const SizedBox(width: 6,),
                          ScanBarcodeComponent(
                            onScanResult: (String scanResult) {
                              final parsedPhoneNumber = scanResult.replaceAll("tel:", "").replaceAll("+62", "0");
                              identityController.text = parsedPhoneNumber;
                            }
                          ),
                          const SizedBox(width: 6,),
                          SelectContactComponent(
                            onTapAction: (String contact) {
                              final parsedPhoneNumber = contact.replaceAll("+62", "0");
                              identityController.text = parsedPhoneNumber;
                            }
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      BlocBuilder<CheckIdentityCubit, CheckIdentityState>(
                        builder: (_, state) {
                          return Column(
                            children: [
                              LoadingButtonComponent(
                                label: "Proses", 
                                buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if(identityController.text.isEmpty) {
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      "ID Pelanggan harus diisi telebih dahulu.", 
                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                    );
                                  } else {
                                    checkIdentityCubit.updateState(true, checkIdentityCubit.state.result);

                                    final generatedIdTrx = generateRandomString(8);

                                    locator.get<TransactionService>().checkIdentity(
                                      generatedIdTrx,
                                      widget.kodeProduk, 
                                      identityController.text, 
                                      "5", 
                                      locator.get<UserAppidCubit>().state.userAppId.appId
                                    ).then((value) {
                                      checkIdentityCubit.updateState(false, value);

                                      if(value.success!) {
                                        locator.get<LocalNotificationService>().showLocalNotification(
                                          title: "✅ Cek Tagihan Pelanggan ${value.produk!}", 
                                          body: value.msg!
                                        );

                                        locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.add(
                                          InboxSchema(title: widget.operatorName, 
                                            content: value.msg!, 
                                            status: 1, 
                                            date: DateTime.now()
                                          )
                                        );

                                        final splittedMessage = value.msg!.split("TOTAL").removeLast();
                                        final parsedTotalPay = splittedMessage.replaceAll(RegExp(r"\D"), "");
                                        
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
                                            return TransactionCheckFormComponent(
                                              response: value.msg!, 
                                              productPrice: int.parse(parsedTotalPay), 
                                              onSubmit: (pin) {
                                                showLoadingSubmit(context, "Proses Transaksi...");

                                                final generatedIdTrx2 = generateRandomString(8);

                                                locator.get<TransactionService>().payNow(
                                                  generatedIdTrx2,
                                                  widget.kodeProduk, 
                                                  identityController.text, 
                                                  pin, 
                                                  "6",
                                                  locator.get<UserAppidCubit>().state.userAppId.appId
                                                ).then((value) {
                                                  if(value.success!) {
                                                    context.pop();
                                                    locator.get<LocalNotificationService>().showLocalNotification(
                                                      title: "✅ Transaksi ${value.produk!}", 
                                                      body: value.msg!
                                                    );

                                                    locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.add(
                                                      InboxSchema(title: widget.operatorName, 
                                                        content: value.msg!, 
                                                        status: 1, 
                                                        date: DateTime.now()
                                                      )
                                                    );

                                                    locator.get<TransactionService>().findLastTransaction(generatedIdTrx2).then((trx) {
                                                      context.pushNamed("transaction-detail", extra: {
                                                        'idtrx': trx.idtransaksi!,
                                                        'type': 'TRANSAKSI',
                                                        'total': trx.hARGAJUAL
                                                      });
                                                    }).catchError((e) {
                                                      showDynamicSnackBar(
                                                        context, 
                                                        Iconsax.warning_2, 
                                                        "ERROR", 
                                                        e.toString(), 
                                                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                      );
                                                    });
                                                  } else {
                                                    locator.get<LocalNotificationService>().showLocalNotification(
                                                      title: "❌ Gagal : Transaksi ${value.produk!}", 
                                                      body: value.msg!
                                                    );

                                                    locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.add(
                                                      InboxSchema(title: widget.operatorName, 
                                                        content: value.msg!, 
                                                        status: 0, 
                                                        date: DateTime.now()
                                                      )
                                                    );
                                                    context.pop();
                                                    // showDynamicSnackBar(
                                                    //   context, 
                                                    //   LineIcons.exclamationTriangle, 
                                                    //   "ERROR", 
                                                    //   value.msg!, 
                                                    //   HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                    // );
                                                  }
                                                }).catchError((e) {
                                                  context.pop();
                                                  context.pop();

                                                  showDynamicSnackBar(
                                                    context, 
                                                    Iconsax.warning_2, 
                                                    "ERROR", 
                                                    e.toString(), 
                                                    HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                  );
                                                });                                            
                                              }
                                            );
                                          }
                                        );
                                      } else {
                                        locator.get<LocalNotificationService>().showLocalNotification(
                                          title: "❌ Gagal : Produk ${value.produk!}", 
                                          body: value.msg!
                                        );

                                        locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.add(
                                          InboxSchema(title: widget.operatorName, 
                                            content: value.msg!, 
                                            status: 0, 
                                            date: DateTime.now()
                                          )
                                        );
                                      }

                                    }).catchError((e) {
                                      checkIdentityCubit.updateState(false, checkIdentityCubit.state.result);
                                      showDynamicSnackBar(
                                        context, 
                                        Iconsax.warning_2, 
                                        "ERROR", 
                                        e.toString(), 
                                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                      );
                                    });
                                  }
                                }, 
                                width: 100.w, 
                                height: 50, 
                                isLoading: state.isLoading
                              ),
                              const SizedBox(height: 18,),
                              Container(
                                padding: const EdgeInsets.all(18),
                                width: 96.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: kKeteranganContainerColor
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.info_circle, color: Colors.black,),
                                        const SizedBox(width: 8,),
                                        Text("LANGKAH TRANSAKSI", style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        ),),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Text("1. Masukkan ID Pelanggan.", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    ),),
                                    const SizedBox(height: 4,),
                                    Text("2. Lalu Klik Tombol Proses.", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    ),),
                                    const SizedBox(height: 4,),
                                    Text("3. Setelah Tombol Proses di Klik, Maka akan Muncul Loading pada Tombol Tersebut.", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    ),),
                                    const SizedBox(height: 4,),
                                    Text("4. Ketika Loading Sudah Selesai, Jika Proses Cek ID Pelanggan Sukses, Maka akan Muncul Form Transaksi dan Jika Gagal, Maka akan Muncul Notifikasi Proses Cek ID Pelanggan Gagal.", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    ),),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }  
                      )
                    ],
                  ),
                )
              )
            ]
          )
        )
      ),
    );
  }
}