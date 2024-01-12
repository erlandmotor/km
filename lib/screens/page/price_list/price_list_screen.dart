import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/search_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/pricelist_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/pricelist_search_response.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class PriceListScreen extends StatefulWidget {

  const PriceListScreen({ super.key });

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    final pricelistCubit = context.read<PricelistCubit>();

    locator.get<ProductService>().getPriceListGroup(
      locator.get<UserAppidCubit>().state.userAppId.appId
    ).then((value) {
      pricelistCubit.updateState(false, false, value, PricelistSearchResponse());
    });

    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pricelistCubit = context.read<PricelistCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              Column(
                children: [
                  const CustomContainerAppBar(title: "Daftar Harga", height: 80,),
                  Card(
                    surfaceTintColor: Colors.blue,
                    child: Container(
                      width: 96.w,
                      padding: const EdgeInsets.all(18),
                      child: SearchTextfieldComponent(
                        label: "Cari Data Produk", 
                        hint: "Contoh : AXIS", 
                        controller: searchController,
                        onChanged: (String term) {
                          if(term.isEmpty) {
                            pricelistCubit.updateState(
                              true, 
                              false, 
                              pricelistCubit.state.pricelistGroupData, 
                              pricelistCubit.state.pricelistSearchData
                            );
                            locator.get<ProductService>().getPriceListGroup(
                              locator.get<UserAppidCubit>().state.userAppId.appId
                            ).then((value) {
                              pricelistCubit.updateState(
                                false, 
                                false, 
                                value, 
                                pricelistCubit.state.pricelistSearchData
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
                          } else {
                            pricelistCubit.updateState(
                              true, 
                              true, 
                              pricelistCubit.state.pricelistGroupData, 
                              pricelistCubit.state.pricelistSearchData
                            );
                            locator.get<ProductService>().getPriceLisSearch(
                              locator.get<UserAppidCubit>().state.userAppId.appId,
                              term
                            ).then((value) {
                              pricelistCubit.updateState(
                                false, 
                                true, 
                                pricelistCubit.state.pricelistGroupData, 
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
                          }
                        }
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Expanded(
                    child: BlocBuilder<PricelistCubit, PricelistState>(
                      builder: (_, state) {
                        if(state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if(state.isSearching) {
                            final mappedData = groupBy(state.pricelistSearchData.data!, (obj) => obj.namaoperator).entries.toList();
                            if(state.pricelistSearchData.data!.isEmpty) {
                              return const NoDataComponent(label: "Data Produk Tidak Ditemukan");
                            } else {
                              return ListView.separated(
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (context, index) {
                                  return Card(
                                    surfaceTintColor: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mappedData[index].key!,
                                            style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(height: 18,),
                                          for(var i = 0; i < mappedData[index].value.length; i++)
                                          Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 50.w,
                                                    child: Text(
                                                      mappedData[index].value[i].namaproduk!,
                                                      style: GoogleFonts.openSans(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FormatCurrency.convertToIdr(mappedData[index].value[i].hargajual ?? 0, 
                                                    0),
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if(i != state.pricelistGroupData.data![index].produk!.length - 1)
                                              const Divider()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }, 
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 8,);
                                }, 
                                itemCount: mappedData.length
                              );
                            }
                          } else {
                            return ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                return Card(
                                  surfaceTintColor: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.pricelistGroupData.data![index].namaoperator!,
                                          style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        const SizedBox(height: 18,),
                                        for(var i = 0; i < state.pricelistGroupData.data![index].produk!.length; i++)
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 50.w,
                                                  child: Text(
                                                    state.pricelistGroupData.data![index].produk![i].namaproduk!,
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  FormatCurrency.convertToIdr(state.pricelistGroupData.data![index].produk![i].hargajual ?? 0, 
                                                  0),
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if(i != state.pricelistGroupData.data![index].produk!.length - 1)
                                            const Divider()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }, 
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 8,);
                              }, 
                              itemCount: state.pricelistGroupData.data!.length
                            );
                          }
                        }
                      },
                    )
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}