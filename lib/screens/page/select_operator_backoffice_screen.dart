import "package:adamulti_mobile_clone_new/components/category_item_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_search.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/search_textfield_without_debounce_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/select_operator_backoffice_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class SelectOperatorBackofficeScreen extends StatefulWidget {

  const SelectOperatorBackofficeScreen({ super.key, required this.operatorName, required this.operatorId });

  final String operatorName;
  final String operatorId;

  @override
  State<SelectOperatorBackofficeScreen> createState() => _SelectOperatorBackofficeScreenState();
}

class _SelectOperatorBackofficeScreenState extends State<SelectOperatorBackofficeScreen> {
  final searchController = TextEditingController();
  final popupMenuController = CustomPopupMenuController();

  @override
  void initState() {
    final selectOperatorBackofficeCubit = context.read<SelectOperatorBackofficeCubit>();

    locator.get<BackOfficeService>().getSettingKategoriByKategori(
      widget.operatorId
    ).then((value) {
      selectOperatorBackofficeCubit.updateState(
        false, 
        value,
        value
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
    popupMenuController.dispose();
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
                              label: "Cari Data Operator",
                              hint: "Ketik Nama Operator",
                              controller: searchController,
                              onChanged: (String value) {
                                final selectOperatorBackofficeCubit = context.read<SelectOperatorBackofficeCubit>();
                                final filteredArray = selectOperatorBackofficeCubit.state.fetchedDataList.where((element) {
                                  return element.name!.toLowerCase().contains(value.toLowerCase());
                                }).toList();
                                
                                selectOperatorBackofficeCubit.updateState(
                                  selectOperatorBackofficeCubit.state.isLoading, 
                                  filteredArray, 
                                  selectOperatorBackofficeCubit.state.fetchedDataList
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
                  child: BlocBuilder<SelectOperatorBackofficeCubit, SelectOperatorBackofficeState>(
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
                            return CategoryItemComponent(
                              categoryName: state.dataList[index].title!,
                              imageUrl: "$baseUrlAuth/files/setting-kategori/image/${state.dataList[index].image!}", 
                              title: state.dataList[index].title!,
                              surfaceColor: index % 2 == 0 ? HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!) : Colors.white, 
                              onTap: () {
                                context.pushNamed("select-product", extra: {
                                  "operatorName": state.dataList[index].name,
                                  "operatorId": state.dataList[index].kodeproduk
                                });
                              }
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
            ],
          )
        ),
      )
    );
  }
}