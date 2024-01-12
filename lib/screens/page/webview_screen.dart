import 'package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart';
import 'package:adamulti_mobile_clone_new/components/loading_button_component.dart';
import 'package:adamulti_mobile_clone_new/components/regular_textfield_component.dart';
import 'package:adamulti_mobile_clone_new/components/show_loading_submit.dart';
import 'package:adamulti_mobile_clone_new/components/transaction_check_form_component.dart';
import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/function/custom_function.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/services/local_notification_service.dart';
import 'package:adamulti_mobile_clone_new/services/transaction_service.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen(
      {super.key, required this.title, required this.operatorId, required this.url });

  final String title;
  final String operatorId;
  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final webviewController = WebViewController();

  final kodePembayaranController = TextEditingController();

  final popupMenuController = CustomPopupMenuController();

  @override
  void initState() {
    webviewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  void dispose() {
    webviewController.clearCache();
    kodePembayaranController.dispose();
    popupMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          CustomPopupMenu(
            controller: popupMenuController,
            menuBuilder: () => Container(
              width: 90.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
              ),
              padding: const EdgeInsets.all(18),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RegularTextFieldComponent(
                        label: "Kode Pembayaran",
                        hint: "Contoh : 12345",
                        controller: kodePembayaranController,
                        validationMessage: "Kode pembayaran harus diisi.",
                        prefixIcon: Iconsax.barcode,
                        isObsecure: false
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<CheckIdentityCubit, CheckIdentityState>(
                      bloc: context.read<CheckIdentityCubit>(),
                      builder: (_, state) {
                        final checkIdentityCubit = context.read<CheckIdentityCubit>();
                        return LoadingButtonComponent(
                            label: "Proses",
                            buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                            onPressed: () {
                              if (kodePembayaranController.text.isEmpty) {
                                showDynamicSnackBar(
                                  context,
                                  Iconsax.warning_2,
                                  "ERROR",
                                  "ID Pelanggan harus diisi telebih dahulu.",
                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                );
                              } else {
                                final generatedIdTrxCheck = generateRandomString(8);

                                checkIdentityCubit.updateState(
                                  true,
                                  checkIdentityCubit.state.result
                                );
                                locator.get<TransactionService>()
                                .checkIdentity(
                                  generatedIdTrxCheck,
                                  widget.operatorId,
                                  kodePembayaranController.text,
                                  "5",
                                  locator
                                      .get<UserAppidCubit>()
                                      .state
                                      .userAppId
                                      .appId
                                ).then((value) {
                                  checkIdentityCubit.updateState(
                                      false, value);
                                  if (value.success!) {
                                    popupMenuController.hideMenu();
                                    final splittedMessage = value.msg!.split("HARGA").removeLast();
                                    final splittedHarga = splittedMessage.split("ADMIN");
                                    final parsedTotalPay = splittedHarga[0].replaceAll(RegExp(r"\D"), "");

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

                                            final generatedIdTrx = generateRandomString(8);

                                            locator.get<TransactionService>().payNow(
                                              generatedIdTrx,
                                              widget.operatorId,
                                              kodePembayaranController.text,
                                              pin,
                                              "6",
                                              locator.get<UserAppidCubit>().state.userAppId.appId
                                              ).then((value) {
                                                if (value.success!) {
                                                  context.pop();
                                                  locator.get<LocalNotificationService>().showLocalNotification(
                                                    title: "Transaksi ${value.produk!}",
                                                    body: "Transaksi ${value.produk!} berhasil dilakukan."
                                                  );

                                                  locator.get<TransactionService>().findLastTransaction(generatedIdTrx).then((trx) {
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
                                                    title: "Transaksi ${value.produk!}",
                                                    body: value.msg!
                                                  );
                                                  context.pop();
                                                }
                                              }
                                            ).catchError((e) {
                                              context.pop();
                                              context.pop();

                                              showDynamicSnackBar(
                                                context,
                                                Iconsax.warning_2,
                                                "ERROR",
                                                e.toString(),
                                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                              );
                                            }
                                          );
                                          }
                                        );
                                      }
                                    );
                                  } else {
                                    locator.get<LocalNotificationService>().showLocalNotification(
                                      title: "Transaksi ${value.produk!}",
                                      body: value.msg!
                                    );
                                  }
                                }).catchError((e) {
                                  checkIdentityCubit.updateState(
                                    false,
                                    checkIdentityCubit.state.result
                                  );
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            pressType: PressType.singleClick,
            verticalMargin: 10,
            horizontalMargin: 10,
            arrowColor: Colors.white,
            barrierColor: Colors.black54,
            showArrow: true,
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.wallet_check,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Bayar",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            )
          )
        ],
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_circle_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          widget.title,
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: WebViewWidget(
        controller: webviewController,
      ),
    );
  }
}
