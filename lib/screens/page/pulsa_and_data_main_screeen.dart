import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/scan_barcode_component.dart";
import "package:adamulti_mobile_clone_new/components/select_contact_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/textfield_with_event_component.dart";
import "package:adamulti_mobile_clone_new/components/transaction_without_identity_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/inbox_schema_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/pulsa_and_data_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/get_product_by_tujuan_response.dart";
import "package:adamulti_mobile_clone_new/schema/inbox_schema.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class PulsaAndDataMainScreen extends StatefulWidget {

  const PulsaAndDataMainScreen({ super.key });

  @override
  State<PulsaAndDataMainScreen> createState() => _PulsaAndDataMainScreenState();
}

class _PulsaAndDataMainScreenState extends State<PulsaAndDataMainScreen> {
  final identityController = TextEditingController();

  @override
  void dispose() {
    identityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulsaAndDataCubit = context.read<PulsaAndDataCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
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
                    const CustomContainerAppBar(title: "Pulsa dan Data", height: 80,),
                    Card(
                      surfaceTintColor: Colors.blue,
                      child: Container(
                        width: 96.w,
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                              Expanded(
                                child: TextfieldWithEventComponent(
                                label: "No. HP Pelanggan", 
                                hint: "Conth: 082xxx",
                                controller: identityController,
                                onChanged: (String value) {
                                  if(value.length >= 4) {
                                    pulsaAndDataCubit.updateState(true, GetProductByTujuanResponse());

                                    locator.get<ProductService>().getProductByTujuan(
                                      locator.get<UserAppidCubit>().state.userAppId.appId, 
                                      value
                                    ).then((result) {
                                      if(result.succes == false) {
                                        pulsaAndDataCubit.updateState(false, GetProductByTujuanResponse());
                                        showDynamicSnackBar(
                                          context, 
                                          Iconsax.warning_2, 
                                          "ERROR", 
                                          "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                        );
                                      } else {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        pulsaAndDataCubit.updateState(false, result);
                                      }
                                    }).catchError((_) {
                                      showDynamicSnackBar(
                                        context, 
                                        Iconsax.warning_2, 
                                        "ERROR", 
                                        "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                      );
                                    });
                                  } else {
                                    pulsaAndDataCubit.updateState(false, GetProductByTujuanResponse());
                                  }
                                }, 
                              ),
                            ),
                            const SizedBox(width: 6,),
                            ScanBarcodeComponent(
                              onScanResult: (String scanResult) {
                                final parsedPhoneNumber = scanResult.replaceAll("tel:", "").replaceAll("+62", "0");
                                identityController.text = parsedPhoneNumber;

                                pulsaAndDataCubit.updateState(true, GetProductByTujuanResponse());

                                locator.get<ProductService>().getProductByTujuan(
                                  locator.get<UserAppidCubit>().state.userAppId.appId, 
                                  identityController.text
                                ).then((result) {
                                  if(result.succes == false) {
                                    pulsaAndDataCubit.updateState(false, GetProductByTujuanResponse());
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                    );
                                  } else {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    pulsaAndDataCubit.updateState(false, result);
                                  }
                                }).catchError((_) {
                                  showDynamicSnackBar(
                                    context, 
                                    Iconsax.warning_2, 
                                    "ERROR", 
                                    "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                    HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                  );
                                });
                              }
                            ),
                            const SizedBox(width: 6,),
                            SelectContactComponent(
                              onTapAction: (String contact) {
                                final parsedPhoneNumber = contact.replaceAll("+62", "0");
                                identityController.text = parsedPhoneNumber;

                                pulsaAndDataCubit.updateState(true, GetProductByTujuanResponse());

                                locator.get<ProductService>().getProductByTujuan(
                                  locator.get<UserAppidCubit>().state.userAppId.appId, 
                                  identityController.text
                                ).then((result) {
                                  if(result.succes == false) {
                                    pulsaAndDataCubit.updateState(false, GetProductByTujuanResponse());
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                    );
                                  } else {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    pulsaAndDataCubit.updateState(false, result);
                                  }
                                }).catchError((_) {
                                  showDynamicSnackBar(
                                    context, 
                                    Iconsax.warning_2, 
                                    "ERROR", 
                                    "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                    HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                  );
                                });
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    BlocBuilder<PulsaAndDataCubit, PulsaAndDataState>(
                      builder: (_, state) {
                        if(state.isLoading) {
                          return const Expanded(child: ShimmerListComponent(isScrollable: false));
                        } else {
                        if(state.productData.data != null) {
                            return Expanded(
                              child: DefaultTabController(
                                length: state.productData.data!.length, 
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      ButtonsTabBar(
                                        onTap: (index) {},
                                        radius: 18,
                                        contentPadding: const EdgeInsets.all(8),
                                        height: 46,
                                        labelSpacing: 4,
                                        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                                        unselectedBackgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
                                        borderColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                                        borderWidth: 0.5,
                                        unselectedBorderColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                                        labelStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                        ),
                                        unselectedLabelStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),
                                        tabs: state.productData.data!.map((e) {
                                          return Tab(
                                            icon: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  imageUrl: e.imgurl!.isEmpty ? state.productData.data!.firstWhere((element) => element.imgurl!.isNotEmpty).imgurl! : 
                                                  e.imgurl!,
                                                ),
                                              ),
                                            ),
                                            text: e.namaoperator,
                                          );
                                        }).toList()
                                      ),
                                      const SizedBox(height: 8,),
                                      Expanded(
                                        child: TabBarView(
                                          children: state.productData.data!.map((data) {
                                            return ListView.separated(
                                              padding: const EdgeInsets.all(8),
                                              itemBuilder: (context, index) {
                                                return ProductItemComponent(
                                                  operatorName: data.namaoperator!,
                                                  imageUrl: data.imgurl!.isEmpty ? state.productData.data!.firstWhere((element) => element.imgurl!.isNotEmpty).imgurl! : 
                                                  data.imgurl!, 
                                                  title: data.namaoperator!,
                                                  productName: data.produk![index].namaproduk!, 
                                                  surfaceColor: index % 2 == 0 ? HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!) : Colors.white,
                                                  onTap: () {
                                                    if(identityController.text.length < 10) {
                                                      showDynamicSnackBar(
                                                        context, 
                                                        Iconsax.warning_2, 
                                                        "ERROR", 
                                                        "Nomor HP Pelanggan Harus Dilengkapi Terlebih Dahulu.", 
                                                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                      );
                                                    } else {
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
                                                          return TransactionWithoutIdentityFormComponent( 
                                                            identityNumber: identityController.text,
                                                            operatorName: data.produk![index].namaoperator!,
                                                            productName: data.produk![index].namaproduk!,
                                                            productPrice: data.produk![index].hargajual!,
                                                            onSubmit: (pin) {
                                                              showLoadingSubmit(context, "Proses Transaksi...");

                                                              final generatedIdTrx = generateRandomString(8);
                                                              
                                                              locator.get<TransactionService>().payNow(
                                                                generatedIdTrx,
                                                                data.produk![index].kodeproduk!, 
                                                                identityController.text, 
                                                                pin,
                                                                "0", 
                                                                locator.get<UserAppidCubit>().state.userAppId.appId
                                                              ).then((value) {
                                                                if(value.success!) {
                                                                  identityController.clear();
                                                                  context.pop();
                                                                  locator.get<LocalNotificationService>().showLocalNotification(
                                                                    title: "✅ Transaksi ${data.produk![index].namaproduk}", 
                                                                    body: "Transaksi ${data.produk![index].namaproduk} berhasil dilakukan."
                                                                  );

                                                                  locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.add(
                                                                    InboxSchema(title: data.produk![index].namaproduk!, 
                                                                      content: value.msg!, 
                                                                      status: 1, 
                                                                      date: DateTime.now()
                                                                    )
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
                                                                  locator.get<LocalNotificationService>().showLocalNotification(title: "❌ Gagal : Transaksi ${data.produk![index].namaproduk}", 
                                                                  body: value.msg!);

                                                                  locator.get<InboxSchemaCubit>().state.inboxSchemaBox!.add(
                                                                    InboxSchema(title: data.produk![index].namaproduk!, 
                                                                      content: value.msg!, 
                                                                      status: 0, 
                                                                      date: DateTime.now()
                                                                    )
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
                                                    }
                                                  },
                                                  price: data.produk![index].hargajual!.toString(),
                                                  productCode: data.produk![index].kodeproduk!,
                                                  description: data.produk![index].keterangan!,
                                                );
                                              }, 
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(height: 4,);
                                              }, 
                                              itemCount: data.produk!.length
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(18),
                              width: 96.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: kKeteranganContainerColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Iconsax.info_circle, color: Colors.black,),
                                      const SizedBox(width: 8,),
                                      Text("LANGKAH TRANSAKSI", style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Text("1. Masukkan Nomor Handphone Minimal 4 Digit.", style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                  Text("2. Lalu Muncul Loading.", style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                  Text("3. Setelah Selesai Loading Pilih Produk yang Diinginkan dengan Cara Mengklik Produk Tersebut.", style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                  Text("4. Lalu Akan Muncul Form Transaksi, Masukkan PIN Anda, Selanjutnya Klik Tombol Proses Transaksi.", style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                            );
                          }
                        }
                      }
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}