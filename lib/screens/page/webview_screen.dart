import 'package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart';
import 'package:adamulti_mobile_clone_new/components/loading_button_component.dart';
import 'package:adamulti_mobile_clone_new/components/regular_textfield_component.dart';
import 'package:adamulti_mobile_clone_new/components/transaction_check_form_component.dart';
import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/services/local_notification_service.dart';
import 'package:adamulti_mobile_clone_new/services/transaction_service.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
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
                          prefixIcon: LineIcons.barcode,
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
                              buttonColor: kMainLightThemeColor,
                              onPressed: () {
                                if (kodePembayaranController.text.isEmpty) {
                                  showDynamicSnackBar(
                                    context,
                                    LineIcons.exclamationTriangle,
                                    "ERROR",
                                    "ID Pelanggan harus diisi telebih dahulu.",
                                    Colors.red
                                  );
                                } else {
                                  checkIdentityCubit.updateState(
                                    true,
                                    checkIdentityCubit.state.result
                                  );
                                  locator.get<TransactionService>()
                                  .checkIdentity(
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
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                const Center(
                                                  child:
                                                      SpinKitFadingCircle(
                                                    color:
                                                        Colors.white,
                                                    size:
                                                        128,
                                                  ),
                                                )
                                              );

                                              locator.get<TransactionService>().payNow(
                                                widget.operatorId,
                                                kodePembayaranController.text,
                                                pin,
                                                "6",
                                                locator.get<UserAppidCubit>().state.userAppId.appId
                                                ).then((value) {
                                                  if (value.success!) {
                                                    context.pop();
                                                    context.pop();
                                                    locator.get<LocalNotificationService>().showLocalNotification(
                                                      title: "Transaksi ${value.produk!}",
                                                      body: "Transaksi ${value.produk!} berhasil dilakukan."
                                                    );
                                                  } else {
                                                    locator.get<LocalNotificationService>().showLocalNotification(
                                                      title: "Transaksi ${value.produk!}",
                                                      body: value.msg!
                                                    );
                                                    context.pop();
                                                    // showDynamicSnackBar(
                                                    //   context,
                                                    //   LineIcons.exclamationTriangle,
                                                    //   "ERROR",
                                                    //   value.msg!,
                                                    //   Colors.red
                                                    // );
                                                  }
                                                }
                                              ).catchError((e) {
                                                context.pop();
                                                context.pop();

                                                showDynamicSnackBar(
                                                  context,
                                                  LineIcons.exclamationTriangle,
                                                  "ERROR",
                                                  e.toString(),
                                                  Colors.red
                                                );
                                              }
                                            );
                                            }
                                          );
                                        }
                                      );
                                    }
                                  }).catchError((e) {
                                    checkIdentityCubit.updateState(
                                      false,
                                      checkIdentityCubit.state.result
                                    );
                                    showDynamicSnackBar(
                                      context,
                                      LineIcons.exclamationTriangle,
                                      "ERROR",
                                      e.toString(),
                                      Colors.red
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
                      LineIcons.wallet,
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
              ))
        ],
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: kMainThemeColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kMainThemeColor,
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
