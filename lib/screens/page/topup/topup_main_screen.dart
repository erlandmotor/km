import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_history_item_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/topup_history_response.dart";
import "package:adamulti_mobile_clone_new/services/topup_service.dart";
import "package:flutter/material.dart";
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
                                  const SizedBox(height: 8,),
                                  DynamicSizeButtonComponent(
                                    label: "Proses", 
                                    buttonColor: kMainLightThemeColor, 
                                    onPressed: () {}, 
                                    width: 100.w, 
                                    height: 50
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