import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_search.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/search_textfield_without_debounce_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/transaction_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/select_product_transaction_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class SelectProductTransactionScreen extends StatefulWidget {

  const SelectProductTransactionScreen({ super.key, required this.operatorName, required this.operatorId });

  final String operatorName;
  final String operatorId;

  @override
  State<SelectProductTransactionScreen> createState() => _SelectProductTransactionScreenState();
}

class _SelectProductTransactionScreenState extends State<SelectProductTransactionScreen> {
  final popupMenuController = CustomPopupMenuController();
  final searchController = TextEditingController();

  @override
  void initState() {
    final selectProductTransactionCubit = context.read<SelectProductTransactionCubit>();

    locator.get<ProductService>().getProductByOperator(
      locator.get<UserAppidCubit>().state.userAppId.appId,
      widget.operatorId
    ).then((value) {
      selectProductTransactionCubit.updateState(
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
    popupMenuController.dispose();
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
                                final selectProductTransactionCubit = context.read<SelectProductTransactionCubit>();
                                final filteredArray = selectProductTransactionCubit.state.fetchedDataList.where((element) {
                                  return element.namaproduk!.toLowerCase().contains(value.toLowerCase()) || 
                                  element.namaoperator!.toLowerCase().contains(value.toLowerCase());
                                }).toList();
                                
                                selectProductTransactionCubit.updateState(
                                  selectProductTransactionCubit.state.isLoading, 
                                  filteredArray, 
                                  selectProductTransactionCubit.state.fetchedDataList
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
                  child: BlocBuilder<SelectProductTransactionCubit, SelectProductTransactionState>(
                    builder: (_, state) {
                      if(state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            return ProductItemComponent(
                              operatorName: widget.operatorName, 
                              imageUrl: state.dataList[index].imgurloperator!, 
                              title: widget.operatorName,
                              productName: state.dataList[index].namaproduk!,
                              surfaceColor: index % 2 == 0 ? HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!) : Colors.white, 
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18)
                                    )
                                  ), 
                                  builder:(context) {
                                    return TransactionFormComponent(
                                      operatorName: state.dataList[index].namaoperator!, 
                                      productName: state.dataList[index].namaproduk!, 
                                      productPrice: state.dataList[index].hargajual!, 
                                      onSubmit: (tujuan, pin) {
                                        showLoadingSubmit(context, "Proses Transaksi...");

                                        final generatedIdTrx = generateRandomString(8);

                                        locator.get<TransactionService>().payNow(
                                          generatedIdTrx,
                                          state.dataList[index].kodeproduk!, 
                                          tujuan, 
                                          pin, 
                                          "0",
                                          locator.get<UserAppidCubit>().state.userAppId.appId
                                        ).then((value) {
                                          if(value.success!) {
                                            context.pop();
                                            
                                            locator.get<LocalNotificationService>().showLocalNotification(
                                              title: "✅ Transaksi ${state.dataList[index].namaproduk}", 
                                              body: "Transaksi ${state.dataList[index].namaproduk} berhasil dilakukan."
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
                                              title: "❌ Gagal : Transaksi ${state.dataList[index].namaproduk}", 
                                              body: value.msg!
                                            );
                                            context.pop();
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
                              },
                              price: state.dataList[index].hargajual!.toString(),
                              productCode: state.dataList[index].kodeproduk!,
                              description: state.dataList[index].keterangan!,
                            );
                          }, 
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8,);
                          }, 
                          itemCount: state.dataList.length
                        );
                      }
                    },
                  )
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}