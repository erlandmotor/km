import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/transaction_check_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

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

    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBar(
                title: widget.operatorName,
              ),
              Expanded(
                child: Container(
                  decoration: kContainerLightDecoration,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      RegularTextFieldComponent(
                        label: "Masukkan ID Pelanggan", 
                        controller: identityController, 
                        validationMessage: "ID Pelanggan harus diisi.", 
                        prefixIcon: LineIcons.identificationCardAlt, 
                        isObsecure: false
                      ),
                      const SizedBox(height: 8,),
                      BlocBuilder<CheckIdentityCubit, CheckIdentityState>(
                        builder: (_, state) {
                          return Column(
                            children: [
                              LoadingButtonComponent(
                                label: "Proses", 
                                buttonColor: kMainLightThemeColor, 
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if(identityController.text.isEmpty) {
                                    showDynamicSnackBar(
                                      context, 
                                      LineIcons.exclamationTriangle, 
                                      "ERROR", 
                                      "ID Pelanggan harus diisi telebih dahulu.", 
                                      Colors.red
                                    );
                                  } else {
                                    checkIdentityCubit.updateState(true, checkIdentityCubit.state.result);

                                    locator.get<TransactionService>().checkIdentity(
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
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context, 
                                                  builder: (context) => const Center(
                                                    child: SpinKitFadingCircle(
                                                      color: Colors.white,
                                                      size: 128,
                                                    ),
                                                  )
                                                );

                                                locator.get<TransactionService>().payNow(
                                                  widget.kodeProduk, 
                                                  identityController.text, 
                                                  pin, 
                                                  "6",
                                                  locator.get<UserAppidCubit>().state.userAppId.appId
                                                ).then((value) {
                                                  if(value.success!) {

                                                  } else {
                                                    locator.get<LocalNotificationService>().showLocalNotification(title: "Hello Notification", body: "It Works");
                                                    context.pop();
                                                    showDynamicSnackBar(
                                                      context, 
                                                      LineIcons.exclamationTriangle, 
                                                      "ERROR", 
                                                      value.msg!, 
                                                      Colors.red
                                                    );
                                                  }
                                                }).catchError((e) {
                                                  context.pop();
                                                  context.pop();

                                                  showDynamicSnackBar(
                                                    context, 
                                                    LineIcons.exclamationTriangle, 
                                                    "ERROR", 
                                                    e.toString(), 
                                                    Colors.red
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
                                        LineIcons.exclamationTriangle, 
                                        "ERROR", 
                                        e.toString(), 
                                        Colors.red
                                      );
                                    });
                                  }
                                }, 
                                width: size.width, 
                                height: 50, 
                                isLoading: state.isLoading
                              ),
                              const SizedBox(height: 8,),
                              if(state.result.success != null && state.result.success! == false) Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(LineIcons.exclamationTriangle, color: Colors.white,
                                    size: 32,),
                                    const SizedBox(width: 8,),
                                    Flexible(
                                      child: Text(
                                        state.result.msg!, style: GoogleFonts.inter(
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