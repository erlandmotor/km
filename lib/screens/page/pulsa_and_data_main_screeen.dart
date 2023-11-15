import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/textfield_with_event_component.dart";
import "package:adamulti_mobile_clone_new/components/transaction_without_identity_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/pulsa_and_data_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/get_product_by_tujuan_response.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_contacts/flutter_contacts.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
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
                Column(
                  children: [
                    const SizedBox(
                      height: 150,
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
                                validationMessage: "ID Pelanggan harus diisi.",
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
                                          LineIcons.exclamationTriangle, 
                                          "ERROR", 
                                          "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                          Colors.red
                                        );
                                      } else {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        pulsaAndDataCubit.updateState(false, result);
                                      }
                                    }).catchError((_) {
                                      showDynamicSnackBar(
                                        context, 
                                        LineIcons.exclamationTriangle, 
                                        "ERROR", 
                                        "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                        Colors.red
                                      );
                                    });
                                  } else {
                                    pulsaAndDataCubit.updateState(false, GetProductByTujuanResponse());
                                  }
                                }, 
                              ),
                            ),
                            const SizedBox(width: 6,),
                            IconButton.filled(
                              iconSize: 24,
                              padding: const EdgeInsets.all(8),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green
                              ),
                              onPressed: () {
                                FlutterContacts.requestPermission().then((value) async {
                                  if(value) {
                                    final contacts = await FlutterContacts.openExternalPick();
                                    if(contacts != null) {
                                      final parsedPhoneNumber = contacts.phones[0].normalizedNumber.replaceAll("+62", "0");
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
                                            LineIcons.exclamationTriangle, 
                                            "ERROR", 
                                            "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                            Colors.red
                                          );
                                        } else {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          pulsaAndDataCubit.updateState(false, result);
                                        }
                                      }).catchError((_) {
                                        showDynamicSnackBar(
                                          context, 
                                          LineIcons.exclamationTriangle, 
                                          "ERROR", 
                                          "Terjadi Kesalahan Ketika Mendapatkan Data Produk, Silahkan Coba Lagi untuk Memasukkan No. HP Pelanggan.", 
                                          Colors.red
                                        );
                                      });
                                    }
                                  } else {
                                    showDynamicSnackBar(
                                      context, 
                                      LineIcons.exclamationTriangle, 
                                      "ERROR", 
                                      "Anda harus mengizinkan applikasi untuk mengakses kontak anda.", 
                                      Colors.red
                                    );
                                  }
                                });
                              }, 
                              icon: const Icon(Icons.contact_phone_outlined)
                            )
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
                                        radius: 8,
                                        contentPadding: const EdgeInsets.all(12),
                                        buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
                                        height: 46,
                                        labelSpacing: 4,
                                        backgroundColor: kMainLightThemeColor,
                                        unselectedBackgroundColor: const Color(0xffdfe4ea),
                                        borderColor: kMainLightThemeColor,
                                        borderWidth: 0,
                                        unselectedBorderColor: const Color(0xff6a89cc),
                                        labelStyle: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                        ),
                                        unselectedLabelStyle: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                        ),
                                        tabs: state.productData.data!.map((e) {
                                          return Tab(
                                            icon: CircleAvatar(
                                              radius: 18,
                                              child: CachedNetworkImage(
                                                imageUrl: e.imgurl!.isEmpty ? state.productData.data!.firstWhere((element) => element.imgurl!.isNotEmpty).imgurl! : 
                                                e.imgurl!,
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
                                                  operatorColor: kMainLightThemeColor, 
                                                  imageUrl: data.imgurl!.isEmpty ? state.productData.data!.firstWhere((element) => element.imgurl!.isNotEmpty).imgurl! : 
                                                  data.imgurl!, 
                                                  title: data.namaoperator!,
                                                  productName: data.produk![index].namaproduk!, 
                                                  onTap: () {
                                                    if(identityController.text.length < 10) {
                                                      showDynamicSnackBar(
                                                        context, 
                                                        LineIcons.exclamationTriangle, 
                                                        "ERROR", 
                                                        "Nomor HP Pelanggan Harus Dilengkapi Terlebih Dahulu.", 
                                                        Colors.red
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
                                                              
                                                              locator.get<TransactionService>().payNow(
                                                                data.produk![index].kodeproduk!, 
                                                                identityController.text, 
                                                                pin,
                                                                "0", 
                                                                locator.get<UserAppidCubit>().state.userAppId.appId
                                                              ).then((value) {
                                                                if(value.success!) {
                                                                  identityController.clear();
                                                                  context.pop();
                                                                  context.pop();
                                                                  // showDynamicSnackBar(
                                                                  //   context, 
                                                                  //   LineIcons.infoCircle, 
                                                                  //   "SUKSES", 
                                                                  //   "Transaksi ${snapshot.data!.data![index].namaproduk} berhasil dilakukan.", 
                                                                  //   Colors.lightBlue
                                                                  // );
                                                                  locator.get<LocalNotificationService>().showLocalNotification(
                                                                    title: "Transaksi ${data.produk![index].namaproduk}", 
                                                                    body: "Transaksi ${data.produk![index].namaproduk} berhasil dilakukan."
                                                                  );
                                                                } else {
                                                                  locator.get<LocalNotificationService>().showLocalNotification(title: "Transaksi ${data.produk![index].namaproduk}", 
                                                                  body: value.msg!);
                                                                  context.pop();
                                                                  // showDynamicSnackBar(
                                                                  //   context, 
                                                                  //   LineIcons.exclamationTriangle, 
                                                                  //   "ERROR", 
                                                                  //   value.msg!, 
                                                                  //   Colors.red
                                                                  // );
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
                                color: const Color(0xffc8d6e5)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(LineIcons.infoCircle, color: Colors.black,),
                                      const SizedBox(width: 8,),
                                      Text("LANGKAH TRANSAKSI", style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Text("1. Masukkan Nomor Handphone Minimal 4 Digiti.", style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                  Text("2. Lalu Muncul Loading.", style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                  Text("3. Setelah Selesai Loading Pilih Produk yang Diinginkan dengan Cara Mengklik Produk Tersebut.", style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  const SizedBox(height: 4,),
                                  Text("4. Lalu Akan Muncul Form Transaksi, Masukkan PIN Anda, Selanjutnya Klik Tombol Proses Transaksi.", style: GoogleFonts.inter(
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