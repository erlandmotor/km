import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_history_item_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/topup_history_response.dart";
import "package:adamulti_mobile_clone_new/services/topup_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import 'package:responsive_sizer/responsive_sizer.dart';

class TopupMainScreen extends StatefulWidget {
  const TopupMainScreen({ super.key });

  @override
  State<TopupMainScreen> createState() => _TopupMainScreenState();
}

class _TopupMainScreenState extends State<TopupMainScreen> {
  final topupController = TextEditingController(text: "Rp. 50.000");

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
                                    prefixIcon: Iconsax.wallet_add,
                                  ),
                                  const SizedBox(height: 18,),
                                  BlocBuilder<TopupSaldoCubit, TopupSaldoState>(
                                    builder: (_, state) {
                                      return LoadingButtonComponent(
                                        isLoading: state.isLoading,
                                        label: "Proses", 
                                        buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                        onPressed: () {
                                          final amount = topupController.text.replaceAll(RegExp(r"\D"), "");
                                          if(int.parse(amount) < 50000) {
                                            showDynamicSnackBar(
                                              context, 
                                              Iconsax.warning_2, 
                                              "ERROR", 
                                              "Nominal Topup Minimal Harus Rp. 50.000.", 
                                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                            );
                                          } else {
                                            context.pushNamed("topup-metode-pembayaran", extra: {
                                              "amount": int.parse(amount)
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
                                    child: CircularProgressIndicator(),
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