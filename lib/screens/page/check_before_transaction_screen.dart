import "package:adamulti_mobile_clone_new/components/check_text_field_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/select_contact_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/transaction_check_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
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
                              const SizedBox(height: 8,),
                              if(state.result.success != null && state.result.success! == false) Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Iconsax.warning_2, color: Colors.white,
                                    size: 32,),
                                    const SizedBox(width: 8,),
                                    Flexible(
                                      child: Text(
                                        state.result.msg!, style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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