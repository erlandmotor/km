import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_history_item_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/topup_history_response.dart";
import "package:adamulti_mobile_clone_new/model/topup_reply_response.dart";
import "package:adamulti_mobile_clone_new/services/topup_service.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import 'package:responsive_sizer/responsive_sizer.dart';

class TopupMainScreen extends StatefulWidget {
  const TopupMainScreen({ super.key });

  @override
  State<TopupMainScreen> createState() => _TopupMainScreenState();
}

class _TopupMainScreenState extends State<TopupMainScreen> {
  final topupController = TextEditingController();

  @override
  void dispose() {
    topupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Expanded(
                    child: Container(
                      decoration: kContainerLightDecoration,
                    )
                  )
                ],
              ),
              Column(
                children: [
                  const CustomContainerAppBar(title: "Topup", height: 80,),
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
                                  TopupTextFieldComponent(
                                    label: "Nominal Topup", 
                                    hint: "Minimal Rp. 50.000", 
                                    controller: topupController, 
                                    validationMessage: "Nominal harus diisi.", 
                                    prefixIcon: LineIcons.wavyMoneyBill, 
                                    isObsecure: false
                                  ),
                                  const SizedBox(height: 18,),
                                  BlocBuilder<TopupSaldoCubit, TopupSaldoState>(
                                    builder: (_, state) {
                                      return LoadingButtonComponent(
                                        isLoading: state.isLoading,
                                        label: "Proses", 
                                        buttonColor: kMainLightThemeColor, 
                                        onPressed: () {
                                          final amount = topupController.text.replaceAll(RegExp(r"\D"), "");
                                          if(int.parse(amount) < 50000) {
                                            showDynamicSnackBar(
                                              context, 
                                              LineIcons.exclamationTriangle, 
                                              "ERROR", 
                                              "Nominal Topup Minimal Harus Rp. 50.000.", 
                                              Colors.red
                                            );
                                          } else {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            final topupSaldoCubit = context.read<TopupSaldoCubit>();
                                            topupSaldoCubit.updateState(true, TopupReplyResponse());
                                            locator.get<TopupService>().proceedDepositTiket(
                                              locator.get<UserAppidCubit>().state.userAppId.appId,
                                              amount
                                            ).then((response) {
                                              topupSaldoCubit.updateState(false, response);
                                              showModalBottomSheet(
                                                context: context, 
                                                builder: (context) {
                                                  return Padding(
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text("Informasi Deposit Bank", style: GoogleFonts.inter(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                              ),),
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                }, 
                                                                icon: const Icon(LineIcons.times, color: Colors.black,)
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(height: 18,),
                                                          Container(
                                                            padding: const EdgeInsets.all(18),
                                                            width: 100.w,
                                                            decoration: kContainerMainDecoration,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Jumlah Transfer", style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colors.white
                                                                ),),
                                                                const SizedBox(height: 12,),
                                                                Text(FormatCurrency.convertToIdr(response.jumlah!, 0), style: GoogleFonts.inter(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.white
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(height: 18,),
                                                          Expanded(
                                                            child: Container(
                                                              width: 100.w,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(18),
                                                                color: const Color(0xffc8d6e5)
                                                              ),
                                                              padding: const EdgeInsets.all(18),
                                                              child: AutoSizeText(response.msg!, 
                                                                maxFontSize: 14,
                                                                style: GoogleFonts.inter(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600
                                                              ),),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            }).catchError((e) {
                                              showDynamicSnackBar(
                                                context, 
                                                LineIcons.exclamationTriangle, 
                                                "ERROR", 
                                                "Nominal Topup Minimal Harus Rp. 50.000.", 
                                                Colors.red
                                              );
                                            });
                                          }                                          
                                        }, 
                                        width: 100.w, 
                                        height: 50
                                      );
                                    }
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Expanded(
                            child: FutureBuilder<TopupHistoryResponse>(
                              future: locator.get<TopupService>().getDespositTiket(locator.get<UserAppidCubit>().state.userAppId.appId), 
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done) {
                                  if(snapshot.hasError) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ListView.separated(
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context, index) {
                                        return TopupHistoryItemComponent(
                                          status: snapshot.data!.data![index].status!, 
                                          nominal: snapshot.data!.data![index].nominal!, 
                                          waktu: snapshot.data!.data![index].waktu!
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 8,);
                                      },
                                    );
                                  }
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    ),
                                  );
                                }
                              }
                            ),
                          )
                        ],
                      ),   
                    )
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}