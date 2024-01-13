import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_search.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/search_textfield_without_debounce_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/select_product_ppob_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class SelectProductPpobScreen extends StatefulWidget {

  const SelectProductPpobScreen({ super.key, required this.operatorName, required this.operatorId });

  final String operatorName;
  final String operatorId;

  @override
  State<SelectProductPpobScreen> createState() => _SelectProductPpobScreenState();
}

class _SelectProductPpobScreenState extends State<SelectProductPpobScreen> {

  final searchController = TextEditingController();
  final popupMenuController = CustomPopupMenuController();

  @override
  void initState() {
    final selectProductPpobCubit = context.read<SelectProductPpobCubit>();

    locator.get<ProductService>().getProductByBackoffice(
      widget.operatorId, 
      locator.get<UserAppidCubit>().state.userAppId.appId
    ).then((value) {
      selectProductPpobCubit.updateState(
        false, 
        value.data!,
        value.data!
      );
    }).catchError((e) {
      showDynamicSnackBar(
        context, 
        Iconsax.warning_2, 
        "ERROR", 
        e.toString(), 
        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBarWithSearch(
                title: widget.operatorName, 
                height: 90, 
                searchWidget: CustomPopupMenu(
                  position: PreferredPosition.bottom,
                  controller: popupMenuController,
                  menuBuilder: () {
                    return GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        width: 90.w,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchTextfieldWithoutDebounceComponent(
                              label: "Cari Data Produk",
                              hint: "Ketik Nama Produk",
                              controller: searchController,
                              onChanged: (String value) {
                                final selectProductPpobCubit = context.read<SelectProductPpobCubit>();
                                final filteredArray = selectProductPpobCubit.state.fetchedDataList.where((element) {
                                  return element.namaproduk!.toLowerCase().contains(value.toLowerCase()) || 
                                  element.namaoperator!.toLowerCase().contains(value.toLowerCase());
                                }).toList();
                                
                                selectProductPpobCubit.updateState(
                                  selectProductPpobCubit.state.isLoading, 
                                  filteredArray, 
                                  selectProductPpobCubit.state.fetchedDataList
                                );
                              },
                              onSubmitted: () {
                                popupMenuController.hideMenu();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }, 
                  pressType: PressType.singleClick,
                  verticalMargin: 10,
                  horizontalMargin: 10,
                  arrowColor: Colors.white,
                  barrierColor: Colors.black54,
                  showArrow: true,
                  
                  child: const Icon(Iconsax.search_normal_1, size: 24, color: Colors.white,)
                )
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
                  child: BlocBuilder<SelectProductPpobCubit, SelectProductPpobState>(
                    builder: (_, state) {
                      if(state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: state.dataList.length,
                          itemBuilder: (context, index) {
                            return ProductItemComponent(
                              operatorName: widget.operatorName,
                              imageUrl: widget.operatorName.contains("PDAM") ? state.dataList[index].imgurloperator! 
                              : state.dataList[index].imgurl!, 
                              title: widget.operatorName,
                              productName: state.dataList[index].namaproduk!, 
                              surfaceColor: index % 2 == 0 ? HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!) : Colors.white,
                              onTap: () {
                                context.pushNamed("check-before-transaction", extra: {
                                  "operatorName": state.dataList[index].namaproduk,
                                  "kodeproduk": state.dataList[index].kodeproduk
                                });
                              },
                              price: state.dataList[index].hargajual!.toString(),
                              productCode: state.dataList[index].kodeproduk!,
                              description: state.dataList[index].keterangan!,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8,);
                          },
                        );
                      }
                    },
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}